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
      {{- if hasKey .Values "volumes" }}
      volumes:
        {{- .Values.volumes | toYaml | nindent 8 }}
      {{- end }}
      containers:
        - name: {{.Values.name}}
          image: {{.Values.image}}
          imagePullPolicy: {{ .Values.imagePullPolicy }}
          ports:
            - containerPort: {{.Values.port}}
          resources:
            requests:
              memory: {{.Values.memoryRequests}}
              cpu: {{.Values.cpuRequests}}
            limits:
              memory: {{.Values.memoryLimits}}
              cpu: {{.Values.cpuLimits}}
          {{- if hasKey .Values "volumeMounts" }}
          volumeMounts:
            {{- .Values.volumeMounts | toYaml | nindent 12 }}
          {{- end }}
          {{- if or (hasKey .Values "plainEnvs") (hasKey .Values "secretEnvs") }}
          env:
          {{- if hasKey .Values "plainEnvs" }}
            {{- range $index, $env := .Values.plainEnvs }}
            - name: {{ $env.name }}
              value: {{ tpl ($env.value | toString | quote) $ }}
            {{- end }}
          {{- end }}
          {{- if hasKey .Values "secretEnvs" }}
            {{- range $index, $env := .Values.secretEnvs }}
            - name: {{ $env.name }}
              valueFrom:
                secretKeyRef:
                  name: {{ tpl ($env.secretName | toString) $ }}
                  key: {{ $env.secretKey }}
            {{- end }}
          {{- end }}
          {{- end }}