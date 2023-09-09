apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: {{.Values.name}}-hpa
  namespace: {{.Values.namespace}}
spec:
  maxReplicas: {{.Values.maxReplicas}}
  minReplicas: {{.Values.minReplicas}}
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{.Values.name}}-application
  targetCPUUtilizationPercentage: {{.Values.averageUtilization}}
