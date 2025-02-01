# janus-pro-docker-test

NOTE: Gradio seems to make a tunnel to the container, see logs for local port and tunnel address... 

```
docker build -t janus-test-nvidia .
```

```
docker run --gpus all -it janus-test-nvidia /bin/bash
```

Mount model folder tho host to store models between container recreates
```
docker run --gpus all --mount type=bind,source=./models/huggingface/,target=/root/.cache/huggingface/ -p 7860:7860 -it janus-test-nvidia /bin/bash
```

Activate python virtual env

```
source .venv/bin/activate
```

Run: 
```
python3 demo/app_januspro.py
```


## Running non-interactively

Observe output for URL and model loading status
```
docker run --gpus all --mount type=bind,source=./models/huggingface/,target=/root/.cache/huggingface/ -p 7860:7860 janus-test-nvidia
```

or follow logs: 
```
docker ps
```

```
docker logs -f <docker_container_name>
```
