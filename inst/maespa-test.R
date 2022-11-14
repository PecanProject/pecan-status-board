library(rpecanapi)
library(dplyr)
library(tidyr)
library(tibble)
library(purrr)
library(httr)
library(glue)

# Modify for your target machine and authentication
server <- connect("http://141.142.217.168/", "ashiklom", "admin")

# List all available models
models <- GET(
  file.path(server$url, "api", "availableModels/"),
  authenticate(server$user, server$password)
) %>%
  content() %>%
  bind_rows()

default_start_date <- "2004-01-01"
default_end_date <- "2004-12-31"

#' Convert test list columns to `input` lists
configure_inputs <- function(met, model_name, ...) {
  # TODO: Add more inputs.
  input <- list(met = list(source = met))
  if (grepl("ED2", model_name)) {
    # TODO: Get these IDs from the database or from user input. Though they are
    # unlikely to change.
    input <- modifyList(input, list(
      lu = list(id = 294),
      thsum = list(id = 295),
      veg = list(id = 296),
      soil = list(id = 297)
    ))
  }
  input
}

test_list <- read.csv("inst/test-data/maespa-test-list.csv", comment.char = "#",
                      na.strings = "") %>%
  as_tibble() %>%
  # Only test models that are available on the target machine
  inner_join(models, c("model_name", "revision")) %>%
  mutate(
    start_date = if_else(is.na(start_date), default_start_date, as.character(start_date)),
    end_date = if_else(is.na(end_date), default_end_date, as.character(end_date)),
    # TODO: Add more inputs here
    inputs = pmap(., configure_inputs),
    pfts = strsplit(as.character(pfts), "|", fixed = TRUE),
    # ED2-specific customizations
    workflow_list_mods = if_else(
      model_name == "ED2.2",
      list(list(model = list(phenol.scheme = 0,
                             ed_misc = list(output_month = 12),
                             edin = "ED2IN.r2.2.0"))),
      list(list())
    )
  )

test_runs <- test_list %>%
   select_if(colnames(.) %in% names(formals(submit.workflow))) %>%
  mutate(submit = pmap(., submit.workflow, server = server))

#Interactively check the status of runs
finished <- FALSE
while (!finished) {
  # Print a summary table
  Sys.sleep(10)
  message(Sys.time())
  run_status <- test_runs %>%
    mutate(workflow_id = map_chr(submit, "workflow_id"),
           status = map(workflow_id, possibly(get.workflow.status,
                                              list(NA, "Not started")),
                        server = server))
  stages <- run_status %>%
    mutate(stage = map(status, 2) %>% map_chr(tail, 1))
  finished <- !any(stages$stage == "Not started")
  stages %>%
    select(workflow_id, stage) %>%
    print(n = Inf)
}

stages$success_status <-ifelse(grepl("DONE", stages$stage), TRUE, FALSE)
models_name <- search.models(server)
sites_name <- search.sites(server)
stages$model_name <- models_name$models$model_name[match(stages$model_id, models_name$models$model_id)]
stages$site_name <- sites_name$sites$sitename[match(stages$site_id, sites_name$sites$id)]
stages$met <- test_list$met[match(stages$inputs, test_list$inputs)]

# Get Failed Workflows Log

wf_log <- as.data.frame(stages)
path <- "inst/error-logs/Maespa/"
unlink(paste0(path,'*'))

#failed_workflows <- wf_log[!(wf_log$success_status=="TRUE"),]

wf_id <- wf_log$workflow_id

for (i in wf_id) {
  download.workflow.file(server, workflow_id=i, 
                         filename="workflow.Rout", save_as=paste0(path,i,".Rout"))
}

# Get Final Log

txt <- paste0(path,wf_id,'.Rout')

my_df_list <- vector("list", 0)
for (i in txt) {
  tmp <- last_line(i,8)
  tmp <- tmp[3:5]
  tmp <- tail(gsub("[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9]", "", tmp))
  tmp <- toString(tmp)
  filename <- i
  my_df_list[[i]] <- data.frame(filename,tmp)
}

df <- do.call(rbind.data.frame, my_df_list)
df <-  as.data.frame(df)
df[] <- lapply(df, function(x) sub(path, "", x, fixed = TRUE))
df[] <- lapply(df, function(x) sub(".Rout", "", x, fixed = TRUE))
colnames(df) <- c("workflow_id","error_log")
df <- data.frame(df$workflow_id,df$error_log)
colnames(df) <- c("workflow_id","error_log")
final_df <- merge(df,wf_log,by = 'workflow_id')

main_data <- data.frame(final_df$workflow_id,final_df$site_id,final_df$site_name,final_df$success_status,final_df$error_log,final_df$met)
main_data <- lapply(main_data, function(x) sub(', Calls: <Anonymous> ... <Anonymous> -> read.register -> <Anonymous> -> <Anonymous>', "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub('----------"), [1] "---------- PEcAn Workflow Complete ----------", > ', "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub('> print("---------- ', "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub("   user='bety', password='bety', driver='PostgreSQL', write='TRUE') ,  ", "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub("   calling met.process: , ", "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub("SEVERE [PEcAn.DB::convert_input] : ,    ", "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub("   start_date='2004-01-01', end_date='2004-12-31' ,  ", "", x, fixed = TRUE))
main_data <- lapply(main_data, function(x) sub("   ", "", x, fixed = TRUE)) 
error_data <- lapply(main_data, function(x) sub("Calls: <Anonymous> ... %>% -> paste -> <Anonymous> -> reduce_impl -> reduce_init", "", x, fixed = TRUE))

write.csv(error_data, "data/maespa-test/logs/maespa-log-data.csv")


# Generate Data 

stages <- apply(stages,2,as.character)
write.csv(stages, "data/maespa-test/maespa-test_results.csv")

