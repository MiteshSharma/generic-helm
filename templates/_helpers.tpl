{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "application.labels.selector" -}}
app: {{ template "application.name" . }}
{{- end -}}

{{- define "application.labels.chart" -}}
team: {{ .Values.labels.team }}
owner: {{ .Values.labels.owner }}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: {{ .Release.Name | quote }}
{{- end -}}

{{- define "application.namespace" -}}
    {{- if .Values.namespaceOverride }}
        {{- .Values.namespaceOverride -}}
    {{- else -}}
        {{- .Release.Namespace -}}
    {{- end -}}
{{- end }}

{{- define "application.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}