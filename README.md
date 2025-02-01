# janus-pro-docker-test (WIP - NOT YET WORKING) 

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

Run Janus-Pro-7B (requires significant GPU vRAM, some say >=24GB): 
```
python3 demo/app_januspro.py
```

Run Janus (non-pro, less vram required): TODO seems to crash 
```
python3 demo/app.py
```

Run JanusFlow: 
```
python3 demo/app_janusflow.py
```


## Running non-interactively (TODO seems to hang)

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
