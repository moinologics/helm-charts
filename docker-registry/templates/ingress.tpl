apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{.Values.name}}-ingress
  namespace: {{.Values.namespace}}
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: {{.Values.clusterIssuer}}
    cert-manager.io/private-key-rotation-policy: Always
    nginx.ingress.kubernetes.io/proxy-body-size: {{.Values.httpMaxBodySize}}
spec:
  ingressClassName: nginx
  rules:
  - host: {{.Values.host}}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: {{.Values.name}}-service
            port:
              number: 80
  tls:
  - hosts:
      - {{.Values.host}}
    secretName: {{.Values.tlsSecret}}