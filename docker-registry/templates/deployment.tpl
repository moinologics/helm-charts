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
      volumes:
        - name: htpasswd-file
          secret:
            secretName: {{.Values.envSecretName}}
            items:
              key: CONTAINER_REGISTERY_HTPASSWD_FILE
              path: htpasswd
      containers:
        - name: {{.Values.name}}
          image: {{.Values.image}}
          imagePullPolicy: Always
          ports:
            - containerPort: {{.Values.port}}
          volumeMounts:
            - name: htpasswd-file
              mountPath: /data/htpasswd
              subPath: htpasswd
          resources:
            requests:
              memory: {{.Values.memoryRequests}}
              cpu: {{.Values.cpuRequests}}
            limits:
              memory: {{.Values.memoryLimits}}
              cpu: {{.Values.cpuLimits}}
          env:
            - name: REGISTRY_AUTH
              value: htpasswd
            - name: REGISTRY_AUTH_HTPASSWD_REALM
              value: Registry Realm
            - name: REGISTRY_AUTH_HTPASSWD_PATH
              value: /data/htpasswd
            - name: REGISTRY_STORAGE
              value: s3
            - name: REGISTRY_STORAGE_S3_BUCKET
              value: {{.Values.S3_BUCKET}}
            - name: REGISTRY_STORAGE_S3_REGION
              value: {{.Values.S3_REGION}}
            - name: REGISTRY_STORAGE_S3_REGIONENDPOINT
              valueFrom:
                secretKeyRef:
                  name: {{.Values.envSecretName}}
                  key: CONTAINER_REGISTERY_S3_ENDPOINT
            - name: REGISTRY_STORAGE_S3_ACCESSKEY
              valueFrom:
                secretKeyRef:
                  name: {{.Values.envSecretName}}
                  key: CONTAINER_REGISTERY_S3_ACCESS_KEY
            - name: REGISTRY_STORAGE_S3_SECRETKEY
              valueFrom:
                secretKeyRef:
                  name: {{.Values.envSecretName}}
                  key: CONTAINER_REGISTERY_S3_SECRET_KEY
            