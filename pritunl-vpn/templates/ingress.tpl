apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pritunl-vpn-dashboard
  namespace: {{.Values.namespace}}
  annotations:
    ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: {{.Values.ingressTlsClusterIssuer}}
spec:
  ingressClassName: nginx
  rules:
    - host: {{.Values.ingressHost}}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: pritunl-vpn-http
                port:
                  number: 9700
  tls:
    - hosts:
        - {{.Values.ingressHost}}
      secretName: {{.Values.ingressTlsSecret}}
