apiVersion: v1
kind: Service
metadata:
  name: {{.Values.name}}-service
  namespace: {{.Values.namespace}}
spec:
  selector:
    app: {{.Values.name}}
  ports:
    - protocol: TCP
      port: 80
      targetPort: {{.Values.port}}