apiVersion: v1
kind: Service
metadata:
  name: pritunl-vpn-http
  namespace: {{.Values.namespace}}
spec:
  type: ClusterIP
  ports:
    - name: http
      port: 9700
      targetPort: 9700
  selector:
    app: pritunl-vpn
---
apiVersion: v1
kind: Service
metadata:
  name: pritunl-vpn-udp
  namespace: {{.Values.namespace}}
spec:
  type: NodePort
  ports:
    - name: udp
      port: {{.Values.openvpnNodePort}}
      protocol: UDP
      targetPort: {{.Values.openvpnNodePort}}
      nodePort: {{.Values.openvpnNodePort}}
  selector:
    app: pritunl-vpn
