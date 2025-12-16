
## ShadowTrafic Data generator

You can first run the project to ensure everything is working by executing make run locally here, this will start your PostgreSQL database. Following this you can execute run_pg.sh to run the [ShadowTraffic](https://docs.shadowtraffic.io/overview/) data generator producting our 2 data products: 

- `accountsholders` and 
- `transactions`.

If all is working, shut down the PostgreSQL database using make down, At this point you can run the larger project stack. Once ready to "generate" data simply come and execute `run_pg.sh` here. This will produce records into the docker-compose service called postgrescdc which is our 2nd PostgreSQL database. 


- [ShadowTraffic](https://docs.shadowtraffic.io/overview/)
  

### Deploying

Execute `run_pg.sh`, this will run the [ShadowTraffic](https://docs.shadowtraffic.io/overview/) [container](shadowtraffic/shadowtraffic:latest) connected to the host network, allowing localhost as host for the PostgreSQL datastore.

- The simulation configuration is as per the `--config /home/config.json` configuration.

    Take note of the `"throttleMs": 1000` as part of each generator blocks `localconfigs` section, just to slow things down a bit during development

There is also a trial key available at the project [GIT Repo](https://github.com/ShadowTraffic/shadowtraffic-examples) 
    
  - free-trial-license.env
  - free-trial-license-docker.env  

Place License key in `conf/license.env`, 
