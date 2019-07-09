# servo-kv-sfx

Steps
```bash
# Servo
echo "abc" > optune.token
export OPTUNE_ACCOUNT=  # account name
export OPTUNE_APP=  # app name

# Servo SignalFx driver
touch signalfx_api_key  # then put the key into the file

# Start
docker-compose up -d --build
```

# Config.yaml
```yaml
sfx:
  stream_endpoint: https://stream.us1.signalfx.com

  metrics:
    response_time:
      flow_program: |-
        query = filter('deployment', 'a')
        data('RESPONSE_TIME_METRIC_NAME', filter=query, rollup='max').mean(by='instance_id').publish()
      unit: ms

    throughput:
      flow_program: |-
        query = filter('deployment', 'a')
        data('THROUGHPUT_METRIC_NAME', filter=query, rollup='max').mean(by='instance_id').publish()
      unit: req/sec

kv:
  query_cmd: sh query.sh --abc

  adjust_cmd: sh adjust.sh --xyz

  components:
    comp1:
      settings:
        setting_a:
            type: range
            min: 1
            max: 10
            step: 1
            unit: count
        setting_b:
            type: range
            min: 1
            max: 20
            step: 1
            unit: ms
        setting_c:
            type: enum
            unit: type
```
