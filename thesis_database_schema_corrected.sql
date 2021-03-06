USE mysql;

create table education(university_id int primary key,
					   university_name varchar(50),
					   university_specialization varchar(20));

create table application_user(user_id int primary key, 
							  first_name varchar(20),
							  last_name varchar(20),
							  user_name varchar(20),
							  user_password varchar(20),
                              user_role varchar(20));
                              
create table connection(user_id int,  
						conection_id int, 
                        primary key (user_id, conection_id),
                        constraint cCon1 foreign key connection(user_id) references application_user(user_id),
                        constraint cCon2 foreign key connection(conection_id) references application_user(user_id));

create table education_user(university_id int,
							user_id int primary key,
							foreign key education_user(user_id) references application_user(user_id),
                            foreign key education_user(university_id) references education(university_id));

create table skill(skill_id int primary key,
				   skill_name varchar(20),
                   skill_type varchar(20));               
   
create table skill_user(skill_id int,
						user_id int primary key,
                        foreign key skill_user(skill_id) references skill(skill_id),
                        foreign key skill_user(user_id) references application_user(user_id));
 
create table project(project_id int primary key,
				     project_title varchar(50),
				     project_overview varchar(100),
				     project_full_description text, 
				     project_if_archived bool,
				     project_arcivation_date date,
                     project_author int,
					 foreign key project(project_author) references application_user(user_id));

create table project_reference(reference_id int primary key, 
							   project_id int,
							   resource_content varchar(100),
							   foreign key project_reference(project_id) references project(project_id));

create table project_skill(skill_id int,
			               project_id int primary key,
                           foreign key project_skill(skill_id) references skill(skill_id),
                           foreign key project_skill(project_id) references project(project_id));

create table user_project_interaction(user_id int primary key,
									  project_id int,
                                      if_observed bool,
                                      if_liked bool,
                                      if_disliked bool,
                                      if_commented bool,
                                      foreign key user_project_interaction(user_id) references application_user(user_id),
                                      foreign key user_project_interaction(project_id) references project(project_id));

create table judgement(user_id int primary key,
                       project_id int,
					   judgement_content varchar(100),
                       CONSTRAINT cj1 foreign key judgement(user_id) references application_user(user_id),
                       CONSTRAINT cj2 foreign key judgement(project_id) references project(project_id));

create table chat(chat_id int primary key,
				  foreign key chat(chat_id) references project(project_id));					
                
create table message(message_id int primary key,
					 message_content text,
                     user_id int,
                     project_id int, 
                     CONSTRAINT cm1 foreign key message(user_id) references application_user(user_id),
                     CONSTRAINT cm2 foreign key message(project_id) references project(project_id));
				
create table user_in_project(if_participant bool, 
							 if_author bool,
                             user_id int,
                             project_id int,
                             CONSTRAINT cUiP1 foreign key user_in_project(user_id) references application_user(user_id),
							 CONSTRAINT cUiP2 foreign key user_in_project(project_id) references project(project_id));   

insert into education (university_id, university_name, university_specialization) 
values (1, 'PJATK', 'technical'),
	   (2, 'MIMUW', 'technical'),
	   (3, 'Warsaw Univetsity of art', 'art');
       
insert into application_user (user_id, first_name, last_name, user_name,
							  user_password, user_role) 
values (1, 'emma', 'stone', 'es081898', 'passemma1', 'tech student'),
	   (2, 'kyle', 'brown', 'kb081999', 'passkyle1', 'art student'),
       (3, 'anna', 'fry', 'af041998', 'passanna1', 'tech student'),
       (4, 'tihan', 'kozlov', 'tk011997', 'passtihan1', ' art student'),
       (5, 'simon', 'black', 'es021996', 'passsimon1', 'tech student');


insert into education_user (university_id, user_id)
values (1, 1),
	   (1, 3),
       (2, 5),
       (3, 2),
       (3, 4);
       
insert into project(project_id, project_title, project_overview, project_full_description, project_if_archived, project_arcivation_date,  project_author)       
values (1,
		'web app for student collaboration',
		'application will help people with different skills create collaborative projects',
        'We will require 2 developers and ux/ui designer, probably we may discuss detail aspects on a go.',
        Null,
        Null, 
        1),  
        (2,
		'web application to learn sign language',
		'application will help people to learn sign language with easy to use illustrations',
        'We will require 2 developers and ux/ui designer, graphic designer and person with expirience in creating education plans',
        Null,
        Null, 
        2);
 
insert into project(project_id, project_title, project_overview, project_full_description, project_if_archived, project_arcivation_date,  project_author)       
values (3,
		'web ai gallery',
		'application will help people to get familiar with AI via art',
        'We will require 1 developers familiar with AI and CV, also we will require one artist as well.',
        Null,
        Null, 
        4);

insert into connection (user_id, conection_id)
values (1,2),(1,3),(1,4);



select project_title, project_overview from project order by rand() limit 3;
select u.user_name, u.user_role, s.skill_name from application_user u join skill_user su on u.user_id = su.user_id join skill s on s.skill_id = su.skill_id order by rand() limit 3;
SELECT u1.user_name FROM application_user u1 JOIN connection c ON u1.user_id = c.conection_id AND c.user_id = 1 ORDER BY u1.user_name limit 3;
select user_name from application_user where user_id = 1;              
