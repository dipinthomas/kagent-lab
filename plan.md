#what is this repo about
- This repo is about learning kagent lab and we will developing labs as we start playing around and testing.
- keep giving me prompts if some of the test on terminal can be converted into kagent lab.

#lab format
- the focus will be on learning one concept at a time. like kagent installation
- within the lab, we will have steps to follow, like exporting the API key is a step. Running helm command is a step. So one lab is combination of multiple steps.
- each step will have a description and a command to run.
- each step also need to have a validation to check if the step is successful.
- we will folders for each lab, and each step can be a file or a folder based on what is being done.

NOTE: Always prompt me if some of the test on terminal can be converted into kagent lab.

#lab 020-035
- This lab will focus on installation of kagent with kagent CLI and Helm.
step 1: export API key
Set the OpenAI API key as an environment variable.
export OPENAI_API_KEY="your-api-key-here"

step 2: install kagent with kagent CLI
# Download/run the install script
curl https://raw.githubusercontent.com/kagent-dev/kagent/refs/heads/main/scripts/get-kagent | bash

step 3:  install kagent 

kagent install

step 4: validate kagent installation

step 5: uninstall cli installation 
Remove kagent by using the CLI. For more options, see the kagent uninstall command reference.

kagent uninstall

step 6: Install the kagent Helm chart with CRDs.

helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
    --namespace kagent \
    --create-namespace

validation:
- check if the kagent-crds is installed
- count the number of crs installed

step 7: export key
Set the OPENAI_API_KEY environment variable:

export OPENAI_API_KEY="your-api-key-here"
validation: 
- check if the OPENAI_API_KEY is set

step 8: install kagent with helm
Install the kagent Helm chart:

helm install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
    --namespace kagent \
    --set providers.default=openAI \
    --set providers.openAI.apiKey=$OPENAI_API_KEY

validation:
- check if the kagent is installed
- check if the kagent is running
- check number of pods running in kagent namespace

step 9: uninstall helm installation
Remove kagent by using the Helm chart. For more options, see the kagent uninstall command reference.

helm uninstall kagent

validation:
- check if the kagent is uninstalled

