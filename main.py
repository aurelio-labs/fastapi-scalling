import asyncio

from fastapi import FastAPI, Request
from prometheus_client import Gauge, make_asgi_app

app = FastAPI()

# Create a gauge for in-flight requests
in_flight_gauge = Gauge("in_flight_requests", "Number of in-flight requests")


@app.middleware("http")
async def track_requests(request: Request, call_next):
    in_flight_gauge.inc()  # Increment gauge
    response = await call_next(request)
    in_flight_gauge.dec()  # Decrement gauge
    print(f"In-flight requests: {in_flight_gauge._value.get()}")
    return response



app.mount("/metrics", make_asgi_app())


@app.get("/health")
async def health():
    return {"status": "ok"}


@app.get("/chat")
async def chat():
    await asyncio.sleep(10)
    return {"in_flight_requests": in_flight_gauge._value.get()}
