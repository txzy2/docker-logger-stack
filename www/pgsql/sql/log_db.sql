
CREATE TABLE incidents (
    id SERIAL PRIMARY KEY,  
    incident_text TEXT NOT NULL, 
    incident_type_id INT NOT NULL,  
    "to" VARCHAR(255) NOT NULL,  -
    incident_object VARCHAR(50) NOT NULL,  
    source TEXT NOT NULL,  
    "date" DATE NOT NULL,  
    count INTEGER NOT NULL  
);

CREATE TABLE send_template (
    id SERIAL PRIMARY KEY, 
    incident_type TEXT NOT NULL,  
    template VARCHAR(255) NOT NULL  
);
