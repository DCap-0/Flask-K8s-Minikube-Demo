# Flask-K8s-Minikube-Demo

A minimal end-to-end demo that shows how to containerize a Flask application and deploy it on a local Kubernetes cluster using **Minikube**, with special handling for **restricted or unreliable networks** (offline-friendly Docker builds using prebuilt wheels).

---

## Project Structure

```
Flask-K8s-Minikube-Demo
├── backend
│ └── app.py
├── frontend
│ ├── static
│ │ └── style.css
│ └── templates
│ └── index.html
├── wheels
│ └── *.whl
├── dockerfile
├── deployment.yaml
├── requirements.txt
├── project_flow.txt
├── LICENSE
└── README.md
```

---

## Local Development

Run the Flask app directly:

```bash
python3 backend/app.py
```

Acess: [http://127.0.0.1:5000](http://127.0.0.1:5000)

---

## Docker Image (Offline-Friendly)

### 1. Build image

```bash
docker build -t flask-k8s-minikube-demo:latest .
```

### 2. Run container locally

```bash
docker run -p 5000:5000 flask-k8s-minikube-demo:latest
```

---

## Kubernetes with Minikube

### 1. Start Minikube

```bash
minikube start
minikube status
```

If `kubectl` is not installed system-wide, Minikube provides a bundled version:

```bash
alias kubectl="minikube kubectl --"
```

### 2. Load local Docker image into Minikube

Required when external registries are blocked.

```bash
minikube image load flask-k8s-minikube-demo:latest
```

Verify:

```bash
minikube image list
```

### 3. Deploy to Kubernetes

```bash
kubectl apply -f deployment.yaml
```

Check resources:

```bash
kubectl get pods
kubectl get nodes
kubectl get services
```

### 4. Access the application

```bash
minikube service flask-k8s-minikube-demo
```

Or open the Kubernetes dashboard:

```bash
minikube dashboard
```

---

## Scaling & Load Testing

### Add nodes

```bash
minikube start --nodes=2
```

### Observe load balancing

```bash
kubectl get pods
kubectl logs -f <pod-id>
```

You can use **Postman → Performance → Runs** to simulate traffic.

---

## Cleanup

```bash
kubectl delete deployment flask-k8s-minikube-demo
minikube stop
```

---

## Docker Hub (Optional)

```bash
docker tag flask-k8s-minikube-demo:latest dcap27/flask-k8s-minikube-demo:latest
docker push dcap27/flask-k8s-minikube-demo:latest
```

---

## Notes

- Uses prebuilt Python wheels to avoid network/DNS issues during Docker builds.
- Uses `minikube kubectl --` for environments where `apt/snap` installs are blocked.
- Designed for learning, demos, and local Kubernetes experimentation.

---

## License

MIT
