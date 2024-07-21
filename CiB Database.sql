-- Start of CREATE --

CREATE TABLE configuration_item
(
configuration_ID INT NOT NULL,
name VARCHAR2(10) NOT NULL,
description VARCHAR2(100),
application VARCHAR2(20),
production_owner VARCHAR2(20),
version VARCHAR2(10),
business_function VARCHAR2(30),
PRIMARY KEY (configuration_ID)
);

CREATE TABLE incident
(
incident_ID INT NOT NULL,
description VARCHAR2(100) NOT NULL,
configuration_ID INT NOT NULL,
start_time TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
end_time TIMESTAMP DEFAULT SYSTIMESTAMP,
priority VARCHAR2(10) NOT NULL,
status VARCHAR2(10) NOT NULL,
resolution VARCHAR2(100),
PRIMARY KEY (incident_ID),
FOREIGN KEY (configuration_ID) REFERENCES configuration_item(configuration_ID)
);

CREATE TABLE business_user
(
incident_ID int NOT NULL,
name VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
affected_business VARCHAR2(40) NOT NULL,
PRIMARY KEY (incident_ID),
FOREIGN KEY (incident_ID) REFERENCES incident(incident_ID)
);

CREATE TABLE manager
(
manager_ID INT NOT NULL,
name VARCHAR2(20) NOT NULL,
contact_information VARCHAR2(40) NOT NULL,
PRIMARY KEY (manager_ID)
);

CREATE TABLE team
(
team_ID INT NOT NULL,
name VARCHAR2(10),
manager_ID INT NOT NULL,
PRIMARY KEY (team_ID),
FOREIGN KEY (manager_ID) REFERENCES manager(manager_ID)
);

CREATE TABLE resolver
(
resolver_ID INT NOT NULL,
name VARCHAR2(20),
contact_information VARCHAR2(40) NOT NULL,
PRIMARY KEY (resolver_ID)
);

CREATE TABLE team_resolver_link
(
resolver_ID INT NOT NULL,
team_ID INT NOT NULL,
contribution VARCHAR2(4) NOT NULL,
PRIMARY KEY (resolver_ID, team_ID),
FOREIGN KEY (resolver_ID) REFERENCES resolver(resolver_ID),
FOREIGN KEY (team_ID) REFERENCES team(team_ID)
);

CREATE TABLE task
(
task_ID INT NOT NULL,
resolver_ID INT NOT NULL,
incident_ID INT NOT NULL,
task_type VARCHAR2(10),
deadline TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
acceptance CHAR(1) NOT NULL,
PRIMARY KEY (task_ID, resolver_ID),
FOREIGN KEY (resolver_ID) REFERENCES resolver(resolver_ID),
FOREIGN KEY (incident_ID) REFERENCES incident(incident_ID)
);

CREATE TABLE chat_record
(
time_stamp TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
incident_ID INT NOT NULL,
resolver_ID INT NOT NULL,
incident_conversation VARCHAR2(100),
PRIMARY KEY (time_stamp, incident_ID),
FOREIGN KEY (incident_ID) REFERENCES incident(incident_ID),
FOREIGN KEY (resolver_ID) REFERENCES resolver(resolver_ID)
);

CREATE TABLE executive_summary
(
executive_summary_ID INT NOT NULL,
incident_description VARCHAR2(100) NOT NULL,
impacts_description VARCHAR2(100) NOT NULL,
mitigation_description VARCHAR2(100) NOT NULL,
next_update TIMESTAMP DEFAULT SYSTIMESTAMP,
PRIMARY KEY (executive_summary_ID)
);

CREATE TABLE communication_update
(
incident_ID INT NOT NULL,
incident_status VARCHAR2(10) NOT NULL,
executive_summary_ID INT NOT NULL,
manager_ID INT NOT NULL,
time_stamp TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
url VARCHAR2(50) NOT NULL,
PRIMARY KEY (incident_ID, incident_status),
FOREIGN KEY (incident_ID) REFERENCES incident(incident_ID),
FOREIGN KEY (executive_summary_ID) REFERENCES executive_summary(executive_summary_ID),
FOREIGN KEY (manager_ID) REFERENCES manager(manager_ID)
);

-- End of CREATE --
-- Start of INSERT --

insert into configuration_item (configuration_ID, name, description, application, production_owner, version, business_function) values (40611, 'Plugins', 'New features', 'CMS', 'Torrey Bacup', 17.67, 'Customise software systems');
insert into configuration_item (configuration_ID, name, description, application, production_owner, version, business_function) values (40910, 'Document', 'Information provider to DWK software systems', 'Desktop', 'Peria Trematick', 16.81, 'Learning and Training');
insert into configuration_item (configuration_ID, name, description, application, production_owner, version, business_function) values (40962, 'Scripts', 'Instruction Sequence', 'Data Processing', 'Dierdre Allsepp', 17.51, 'Data Analysis');
insert into configuration_item (configuration_ID, name, description, application, production_owner, version, business_function) values (40082, 'SourceCode', 'Java Instructions', 'Standalone', 'Ninette Arling', 12.38, 'Adapt to changing market');
insert into configuration_item (configuration_ID, name, description, application, production_owner, version, business_function) values (40947, 'Libraries', 'Java Code Modules', 'Enterprise system', 'Karalee Archbould', 16.36, 'Reducing development time');

INSERT INTO incident (incident_ID, description, configuration_ID, start_time, end_time, priority, status, resolution) VALUES (30739, 'Libraries returning empty strings', 40947, TIMESTAMP '2024-05-12 23:01:15', TIMESTAMP '2024-05-12 23:02:21', 'Low', 'Mitigate', 'Check for update issues');
INSERT INTO incident (incident_ID, description, configuration_ID, start_time, end_time, priority, status, resolution) VALUES (30526, 'Source code are empty', 40082, TIMESTAMP '2024-05-07 06:49:03', TIMESTAMP '2024-05-11 19:11:50', 'Medium', 'Closed', 'Version control shows overwritten');
INSERT INTO incident (incident_ID, description, configuration_ID, start_time, end_time, priority, status, resolution) VALUES (30866, 'Script load error', 40962, TIMESTAMP '2024-05-09 21:15:04', TIMESTAMP '2024-05-09 21:20:28', 'High', 'Mitigate', 'Verify permissions');
INSERT INTO incident (incident_ID, description, configuration_ID, start_time, end_time, priority, status, resolution) VALUES (30509, 'Documentation saving error', 40910, TIMESTAMP '2024-05-12 15:20:38', TIMESTAMP '2024-05-12 16:59:23', 'High', 'Detected', 'Verify compatibility');
INSERT INTO incident (incident_ID, description, configuration_ID, start_time, end_time, priority, status, resolution) VALUES (30819, 'Plugin feature fail', 40611, TIMESTAMP '2024-05-09 22:40:39', TIMESTAMP '2024-05-12 22:19:41', 'Medium', 'Closed', 'Plugin debugged');

insert into business_user (incident_ID, name, email, affected_business) values (30739, 'Meriel Huddy', 'mhuddy0@twitter.com', 'VBI Vaccines, Inc.');
insert into business_user (incident_ID, name, email, affected_business) values (30526, 'Alana Fritz', 'afritz1@sitemeter.com', 'Fang Holdings Limited');
insert into business_user (incident_ID, name, email, affected_business) values (30866, 'Antoine Guitt', 'aguitt2@nymag.com', 'Potash Corporation of Saskatchewan Inc.');
insert into business_user (incident_ID, name, email, affected_business) values (30509, 'Keeley Puddephatt', 'kpuddephatt3@xing.com', 'Inphi Corporation');
insert into business_user (incident_ID, name, email, affected_business) values (30819, 'Meredith Ellerington', 'mellerington4@arstechnica.com', 'Templeton Emerging Markets Fund');

insert into manager (manager_ID, name, contact_information) values (10536, 'Iona Seefus', 'iseefus0@domainmarket.com');
insert into manager (manager_ID, name, contact_information) values (10796, 'Angelle Laurand', 'alaurand1@tinyurl.com');
insert into manager (manager_ID, name, contact_information) values (10325, 'Wittie Rowlson', 'wrowlson2@eepurl.com');
insert into manager (manager_ID, name, contact_information) values (10886, 'Kevan Huller', 'khuller3@hud.gov');
insert into manager (manager_ID, name, contact_information) values (10627, 'Willi Kieff', 'wkieff4@php.net');

insert into team (team_ID, name, manager_ID) values (1, 'ByteZap', 10536);
insert into team (team_ID, name, manager_ID) values (2, 'Techify', 10796);
insert into team (team_ID, name, manager_ID) values (3, 'Cybrix', 10325);
insert into team (team_ID, name, manager_ID) values (4, 'CodeX', 10886);
insert into team (team_ID, name, manager_ID) values (5, 'ByteGo', 10627);

insert into resolver (resolver_ID, name, contact_information) values (20658, 'Rosalind Korda', 'rkorda0@lulu.com');
insert into resolver (resolver_ID, name, contact_information) values (20514, 'Jodi Loch', 'jloch1@purevolume.com');
insert into resolver (resolver_ID, name, contact_information) values (20397, 'Padraic McAnulty', 'pmcanulty2@eepurl.com');
insert into resolver (resolver_ID, name, contact_information) values (20867, 'Klement Dowley', 'kdowley3@tiny.cc');
insert into resolver (resolver_ID, name, contact_information) values (20207, 'Melloney Greenhill', 'mgreenhill4@vinaora.com');

insert into team_resolver_link (resolver_ID, team_ID, contribution) values (20207, 4, '100%');
insert into team_resolver_link (resolver_ID, team_ID, contribution) values (20207, 3, '100%');
insert into team_resolver_link (resolver_ID, team_ID, contribution) values (20514, 2, '50%');
insert into team_resolver_link (resolver_ID, team_ID, contribution) values (20658, 2, '50%');
insert into team_resolver_link (resolver_ID, team_ID, contribution) values (20867, 1, '75%');

insert into task (task_ID, resolver_ID, incident_ID, task_type, deadline, acceptance) values (50842, 20658, 30739, 'Mitigation', TIMESTAMP '2024-05-12 23:02:21', 'N');
insert into task (task_ID, resolver_ID, incident_ID, task_type, deadline, acceptance) values (50318, 20514, 30526, 'Validation', TIMESTAMP '2024-05-11 19:11:50', 'Y');
insert into task (task_ID, resolver_ID, incident_ID, task_type, deadline, acceptance) values (50517, 20397, 30866, 'Mitigation', TIMESTAMP '2024-05-09 21:20:28', 'Y');
insert into task (task_ID, resolver_ID, incident_ID, task_type, deadline, acceptance) values (50401, 20867, 30509, 'Diagnose', TIMESTAMP '2024-05-12 16:59:23', 'Y');
insert into task (task_ID, resolver_ID, incident_ID, task_type, deadline, acceptance) values (50942, 20207, 30819, 'Validation', TIMESTAMP '2024-05-12 22:19:41', 'Y');

insert into chat_record (time_stamp, incident_ID, resolver_ID, incident_conversation) values (TIMESTAMP '2024-05-13 17:35:20', 30739, 20658, 'Hi Merial, is there an error message you can send? - Rosa');
insert into chat_record (time_stamp, incident_ID, resolver_ID, incident_conversation) values (TIMESTAMP '2024-05-07 07:00:19', 30526, 20514, 'Hello Alana, are you able to recall any none empty versions? - Jodi');
insert into chat_record (time_stamp, incident_ID, resolver_ID, incident_conversation) values (TIMESTAMP '2024-05-09 21:20:27', 30866, 20397, 'Antonie, could you further explain your load error? - Pad');
insert into chat_record (time_stamp, incident_ID, resolver_ID, incident_conversation) values (TIMESTAMP '2024-05-12 15:25:21', 30509, 20867, 'Keeley, are you able to see if your documentation is compatible with your software?');
insert into chat_record (time_stamp, incident_ID, resolver_ID, incident_conversation) values (TIMESTAMP '2024-05-10 07:52:25', 30819, 20207, 'Hiya Meredith, thank you for responding, I was not given an error message it is just blank');

insert into executive_summary (executive_summary_ID, incident_description, impacts_description, mitigation_description, next_update) values (60604, 'Libraries returning empty strings', 'Impacted functionality and data integrity', 'Investigating update issues', TIMESTAMP '2024-05-16 12:18:11');
insert into executive_summary (executive_summary_ID, incident_description, impacts_description, mitigation_description, next_update) values (60264, 'Source code are empty', 'Potential loss of project data', 'Checking version control history', TIMESTAMP '2024-05-14 19:56:17');
insert into executive_summary (executive_summary_ID, incident_description, impacts_description, mitigation_description, next_update) values (60990, 'Script load error', 'Service disruption and user inconvenience', 'Verifying permissions and access', TIMESTAMP '2024-05-10 05:17:32');
insert into executive_summary (executive_summary_ID, incident_description, impacts_description, mitigation_description, next_update) values (60600, 'Documentation saving error', 'Risk of incomplete or inaccurate documentation', 'Ensuring compatibility with storage systems', TIMESTAMP '2024-05-12 18:27:41');
insert into executive_summary (executive_summary_ID, incident_description, impacts_description, mitigation_description, next_update) values (60980, 'Plugin feature fail', 'Disrupted functionality and user experience', 'Debugging plugin code', TIMESTAMP '2024-05-10 04:10:17');

insert into communication_update (incident_ID, incident_status, executive_summary_ID, manager_ID, time_stamp, url) values (30739, 'Closed', 60604, 10536, TIMESTAMP '2024-05-08 06:10:07', 'https://www.DWK.com/30739');
insert into communication_update (incident_ID, incident_status, executive_summary_ID, manager_ID, time_stamp, url) values (30526, 'Closed', 60264, 10796, TIMESTAMP '2024-05-16 17:47:48', 'https://www.DWK.com/30526');
insert into communication_update (incident_ID, incident_status, executive_summary_ID, manager_ID, time_stamp, url) values (30866, 'Mitigated', 60990, 10325, TIMESTAMP '2024-05-15 20:03:39', 'https://www.DWK.com/30866');
insert into communication_update (incident_ID, incident_status, executive_summary_ID, manager_ID, time_stamp, url) values (30509, 'Mitigated', 60600, 10886, TIMESTAMP '2024-05-11 18:03:48', 'https://www.DWK.com/30509');
insert into communication_update (incident_ID, incident_status, executive_summary_ID, manager_ID, time_stamp, url) values (30819, 'Mitigated', 60980, 10627, TIMESTAMP '2024-05-07 09:08:25', 'https://www.DWK.com/30819');

-- End of INSERT --
-- Start of QUERY --

SELECT * FROM incident WHERE status != 'Resolved';

SELECT * FROM incident WHERE start_time BETWEEN TIMESTAMP '2024-05-12 15:00:00' AND TIMESTAMP '2024-05-13 10:00:00';

SELECT * FROM chat_record WHERE resolver_ID = '20658';

SELECT * FROM chat_record WHERE incident_ID = '30526';

SELECT es.impacts_description, bu.affected_business
FROM executive_summary es
JOIN communication_update cu ON es.executive_summary_ID = cu.executive_summary_ID
JOIN business_user bu ON bu.incident_ID = cu.incident_ID
WHERE cu.incident_ID = 30526;

SELECT description, status FROM incident WHERE incident_ID = 30526;

SELECT m.manager_ID, es.incident_description
FROM manager m
JOIN communication_update cu ON m.manager_ID = cu.manager_ID
JOIN executive_summary es ON cu.executive_summary_ID = es.executive_summary_ID
WHERE cu.incident_ID = 30526;

SELECT i.incident_ID, i.priority
FROM incident i;

-- End of QUERY --
COMMIT;