apiVersion: apps/v1
kind: Deployment
metadata:
  name: pritunl-vpn
  namespace: {{.Values.namespace}}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pritunl-vpn
  template:
    metadata:
      labels:
        app: pritunl-vpn
    spec:
      restartPolicy: Always
      containers:
        - name: pritunl
          image: {{.Values.image}}
          securityContext:
            privileged: true
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: {{.Values.cpuLimit}}
              memory: {{.Values.memoryLimit}}
          ports:
            - containerPort: {{.Values.openvpnNodePort}}
              protocol: UDP
            - containerPort: 9700
          env:
            - name: REVERSE_PROXY
              value: "true"
            - name: WIREGUARD
              value: "false"
            - name: MONGODB_URI
              valueFrom:
                secretKeyRef:
                  name: {{.Values.secretName}}
                  key: {{.Values.mongoDBUriSecretKey}}
