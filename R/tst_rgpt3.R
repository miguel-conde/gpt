library(tidyverse)

devtools::install_github("ben-aaron188/rgpt3")
library(rgpt3)


gpt3_authenticate("access_key.txt")
gpt3_test_completion()


# Making requests (standard GPT models, i.e. before ChatGPT) --------------

# Example 1: making a single completion request
example_1 = gpt3_single_completion(prompt_input = 'Write a cynical text about human nature:'
                                   , temperature = 0.9
                                   , max_tokens = 100
                                   , n = 5)
example_1

# Example 2: multiple prompts
my_prompts = data.frame('prompts' = 
                          c('Complete this sentence: universities are'
                            , 'Write a poem about music:'
                            , 'Which colour is better and why? Red or blue?')
                        ,'prompt_id' = c(LETTERS[1:3]))

example_2 = gpt3_completions(prompt_var = my_prompts$prompts
                             , id_var = my_prompts$prompt_id
                             , param_model = 'text-curie-001'
                             , param_max_tokens = 100
                             , param_n = 5
                             , param_temperature = 0.4)
example_2


# Embeddings --------------------------------------------------------------

data("travel_blog_data")

# Example 1: get embeddings for a single text
# we just take the first text here as a single text example
my_text = travel_blog_data$gpt3[1]
my_embeddings = gpt3_single_embedding(input = my_text)
length(my_embeddings)
# 1024 (since the default model uses the 1024-dimensional Ada embeddings model)

# Example 2: get embeddings from text data in a data.frame / data.table
multiple_embeddings = gpt3_embeddings(input_var = travel_blog_data$gpt3
                                      , id_var = travel_blog_data$n)
dim(multiple_embeddings)

# [1]    10 1025 # because we have ten rows of 1025 columns each (by default 1024 embeddings elements and 1 id variable)


# ChatGPT -----------------------------------------------------------------

# Example 1: making a single chat completion request
chatgpt_example_1 = chatgpt_single(prompt_role = 'user'
                                   , prompt_content = 'You are a cynical, old male writer. Write a cynical text about human nature:'
                                   , temperature = 1.5
                                   , max_tokens = 100
                                   , n = 5)
chatgpt_example_1

# Example 2: multiple prompts
my_chatgpt_prompts = data.frame('prompts_roles' = rep('user', 3)
                                , 'prompts_contents' =
                                  c('You are a bureacrat. Complete this sentence: universities are'
                                    , 'You are an award-winning poet. Write a poem about music:'
                                    , 'Which colour is better and why? Red or blue?')
                                ,'prompt_id' = c(LETTERS[1:3]))

chatgpt_example_2 = chatgpt(prompt_role_var = my_chatgpt_prompts$prompts_roles
                            , prompt_content_var = my_chatgpt_prompts$prompts_contents
                            , id_var = my_chatgpt_prompts$prompt_id
                            , param_max_tokens = 100
                            , param_n = 5
                            , param_temperature = 0.4)
chatgpt_example_2
