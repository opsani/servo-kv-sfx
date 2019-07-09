FROM python:3.5-slim

WORKDIR /servo

# Install dependencies
RUN pip3 install PyYAML requests signalfx
RUN apt install -y openjdk-8-jre-headless

# Install servo
# Bases
ADD https://raw.githubusercontent.com/opsani/servo/master/measure.py \
    https://raw.githubusercontent.com/opsani/servo/master/adjust.py \
    https://raw.githubusercontent.com/opsani/servo/master/servo \
    /servo/

# Measure
ADD https://raw.githubusercontent.com/opsani/servo-sfx/v2/measure \
    /servo/

# Adjust
ADD https://raw.githubusercontent.com/opsani/servo-kv/master/adjust \
    /servo/

# Permissions
RUN chmod u+rwx /servo/servo /servo/measure /servo/adjust

# Do not buffer stdout/stderr
ENV PYTHONUNBUFFERED=1

ENTRYPOINT [ "python3", "servo" ]
