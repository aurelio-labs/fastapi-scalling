from locust import HttpUser, task


class LoadTestUser(HttpUser):
    host = "http://keda.fastapi.localdev.me"

    @task
    def get_docs(self):
        response = self.client.get(
            "/docs",
        )
        if response.status_code != 200:
            print(f"Failed to get docs: {response.status_code} - {response.text}")



# Run locust
# locust -f locust.py --host http://keda.fastapi.localdev.me --users 100 --spawn-rate 10 -t 5m
