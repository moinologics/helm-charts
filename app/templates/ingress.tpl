{{ if hasKey .Values "host" }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{.Values.name}}-ingress
  namespace: {{.Values.namespace}}
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    {{- if hasKey .Values "ingressCors" }}
    {{- range $key, $value := .Values.ingressCors }}
    nginx.ingress.kubernetes.io/cors-{{ $key }}: {{ $value }}
    {{- end }}
    {{- end }}
    cert-manager.io/cluster-issuer: {{.Values.clusterIssuer}}
    cert-manager.io/private-key-rotation-policy: Always
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
              number: {{.Values.port}}
  tls:
  - hosts:
      - {{.Values.host}}
    secretName: {{.Values.tlsSecret}}
{{ end }}