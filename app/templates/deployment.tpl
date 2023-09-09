apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{.Values.name}}-application
  namespace: {{.Values.namespace}}
  labels:
    app: {{.Values.name}}
spec:
  replicas: {{.Values.replicaCount}}
  selector:
    matchLabels:
      app: {{.Values.name}}
  template:
    metadata:
      labels:
        app: {{.Values.name}}
    spec:
      containers:
        - name: {{.Values.name}}
          image: {{.Values.image}}
          imagePullPolicy: Always
          ports:
            - containerPort: {{.Values.port}}
          resources:
            requests:
              memory: {{.Values.memoryRequests}}
              cpu: {{.Values.cpuRequests}}
            limits:
              memory: {{.Values.memoryLimits}}
              cpu: {{.Values.cpuLimits}}
          {{ if hasKey .Values "env" }}
          env: {{ toYaml .Values.env | nindent 10 }}
          {{ end }}
