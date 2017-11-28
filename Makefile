# =========================================== MONITORING ===============================================================

# ----------------------- KIBANA -------------------------------------------------------------------
start-kibana:
	@docker-compose up -d kibana
stop-kibana:
	@docker-compose stop kibana

# ------------------- ELASTICSEARCH ----------------------------------------------------------------
start-elasticsearch:
	@docker-compose up -d elasticsearch
stop-elasticsearch:
	@docker-compose stop elasticsearch


# ------------------- METRICBEAT -------------------------------------------------------------------
stop-metricbeat:
	@echo "== Stopping METRICBEAT=="
	@docker-compose stop metricbeat

# ------------------- MONITORING -------------------------------------------------------------------
create-network:
	@docker network create metricbeat || true
remove-network:
	@docker network rm metricbeat

start-monitoring: create-network start-elasticsearch start-kibana
	@echo "Waiting for elasticsearch..."
	@sleep 15
	@docker-compose up -d metricbeat
	@echo "================= Monitoring STARTED !!!"

stop-monitoring: stop-metricbeat stop-kibana stop-elasticsearch
	@docker-compose stop
	@echo "================= Monitoring STOPPED !!!"



# =================================================== MYSQL ============================================================
compose-mysql=docker-compose -f docker-compose.mysql.yml -p metricbeat_mysql
start-mysql:
	@$(compose-mysql) up -d mysql
stop-mysql:
	@$(compose-mysql) stop mysql

# =================================================== MONGOSB ==========================================================
compose-mongodb=docker-compose -f docker-compose.mongodb.yml -p metricbeat_mongodb
start-mongodb:
	@$(compose-mongodb) up -d mongodb
stop-mongodb:
	@$(compose-mongodb) stop mongodb

# =================================================== RABBITMQ =========================================================
compose-rabbitmq=docker-compose -f docker-compose.rabbitmq.yml -p metricbeat_rabbitmq
start-rabbitmq:
	@$(compose-rabbitmq) up -d rabbitmq
stop-rabbitmq:
	@$(compose-rabbitmq) stop rabbitmq

# =================================================== REDIS ============================================================
compose-redis=docker-compose -f docker-compose.redis.yml -p metricbeat_redis
start-redis:
	@$(compose-redis) up -d redis
stop-redis:
	@$(compose-redis) stop redis

# =================================================== NGINX ============================================================
compose-nginx=docker-compose -f docker-compose.nginx.yml -p metricbeat_nginx
start-nginx:
	@$(compose-nginx) up -d nginx
stop-nginx:
	@$(compose-nginx) stop nginx

# =================================================== APACHE ===========================================================
compose-apache=docker-compose -f docker-compose.apache.yml -p metricbeat_apache
start-apache:
	@$(compose-apache) up -d apache
stop-apache:
	@$(compose-apache) stop apache


start-all: start-apache start-nginx start-redis start-rabbitmq start-mongodb start-mysql

stop-all: stop-apache stop-nginx stop-redis stop-rabbitmq stop-mongodb stop-mysql


