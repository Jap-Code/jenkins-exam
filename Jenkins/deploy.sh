DOCKER_TAG="abc123"
MEM_LIMIT="256Mi"
CPU_LIMIT="500m"
MEM_REQUEST="128Mi"
CPU_REQUEST="250m"
DATABASE_URL="postgres://user:pass@host:5432/db"



# Alle Platzhalter auf einen Schlag ersetzen
sed -e "s|__DOCKER_TAG__|${DOCKER_TAG}|g" \
    -e "s|__MEM_LIMIT__|${MEM_LIMIT}|g" \
    -e "s|__CPU_LIMIT__|${CPU_LIMIT}|g" \
    -e "s|__MEM_REQUEST__|${MEM_REQUEST}|g" \
    -e "s|__CPU_REQUEST__|${CPU_REQUEST}|g" \
    -e "s|__DATABASE_URL__|${DATABASE_URL}|g" \
    values-template.yaml > values.yaml