# Generative AI with LangChain, First Edition
## 137 Particles Fork

Welcome to my fork of the codebase for the "Generative AI" book. This repository is entirely based on the original author's code. My objective here is to make and track bug fixes and improvements as I progress through the text. It's important to note that I do not claim any ownership of this code. All rights and the chosen license remain as specified by the original author.

The purpose of this file is to document my personal notes and changes specific to this fork.

For reference, the original `README.md` from the base repository has been renamed to `ORIGINAL_README.md` in this fork.

### Getting Started with the Docker Container

To launch the Docker container and pass in your OpenAI API key, use the following command:

```bash
docker run -d -p 8888:8888 -e OPENAI_API_KEY="PUT_YOUR_API_KEY_HERE" langchain_ai
```

Replace `PUT_YOUR_API_KEY_HERE` with your actual OpenAI API key.

### Accessing the Shell of the Docker Container

If you need to access the shell of the running Docker container, execute this command:

```bash
docker exec -it $(docker ps --filter "ancestor=langchain_ai" -q | head -n 1) /bin/bash
```

This command will open a Bash shell in the first `langchain_ai` container instance that it finds running.
