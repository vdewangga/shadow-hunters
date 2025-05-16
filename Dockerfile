# Stage 1: builder
FROM python:3.8-alpine AS builder

# Install build tools and general dependecies
RUN apk add --no-cache build-base

WORKDIR /app

COPY requirements.txt .

# Install deps to other foler
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

# Stage 2: final image (runtime only)
FROM python:3.8-alpine

WORKDIR /app

# Install package runtime only
COPY --from=builder /install /usr/local
COPY . .

EXPOSE 5000

CMD ["python", "shadow-hunters/app.py"]
