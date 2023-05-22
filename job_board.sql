CREATE SCHEMA IF NOT EXISTS job_board;

CREATE TABLE
    IF NOT EXISTS job_board.recruiter (
        recruiter_id SERIAL NOT NULL PRIMARY KEY,
        uuid UUID NOT NULL UNIQUE,
        email VARCHAR(100) NOT NULL UNIQUE,
        password VARCHAR(45) NOT NULL,
        disabled BOOLEAN NOT NULL DEFAULT false,
        company_name VARCHAR(45),
        company_description VARCHAR(500)
    );

CREATE TABLE
    IF NOT EXISTS job_board.job_offer (
        job_offer_id SERIAL NOT NULL PRIMARY KEY,
        uuid UUID NOT NULL UNIQUE,
        title VARCHAR(45) NOT NULL,
        description VARCHAR(1000) NOT NULL,
        city VARCHAR(45) NOT NULL,
        recruiter_id UUID NOT NULL,
        CONSTRAINT fk_recruiter_job_offer FOREIGN KEY (recruiter_id) REFERENCES job_board.recruiter (uuid) ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE
    IF NOT EXISTS job_board.candidate (
        candidate_id SERIAL NOT NULL PRIMARY KEY,
        uuid UUID NOT NULL UNIQUE,
        firstname VARCHAR(45) NOT NULL,
        lastname VARCHAR(45) NOT NULL,
        email VARCHAR(100) NOT NULL UNIQUE,
        phone VARCHAR(45) NOT NULL,
        presentation VARCHAR(500) NOT NULL,
        disabled BOOLEAN NOT NULL DEFAULT false
    );

CREATE TABLE
    IF NOT EXISTS job_board.candidate_has_job_offer (
        candidate_id UUID NOT NULL,
        job_offer_id UUID NOT NULL,
        PRIMARY KEY (candidate_id, job_offer_id),
        CONSTRAINT fk_candidate_has_job_offer_candidate1 FOREIGN KEY (candidate_id) REFERENCES job_board.candidate (uuid) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_candidate_has_job_offer_job_offer1 FOREIGN KEY (job_offer_id) REFERENCES job_board.job_offer (uuid) ON DELETE CASCADE ON UPDATE CASCADE
    );

INSERT into
    job_board.candidate (
        uuid,
        firstname,
        lastname,
        email,
        phone,
        presentation
    )
values (
        '4649605c-6cfb-4829-a033-ce1a7fa06e45',
        'candidate1',
        'lastname1',
        'candidate1@gmail.com',
        '0606060606',
        'Je suis le candidat 1'
    ), (
        'c09e93c0-1980-4a13-9797-581539f33d96',
        'candidate2',
        'lastname2',
        'candidate2@gmail.com',
        '0606060606',
        'Je suis le candidat 2'
    ), (
        '97142cea-c071-4c7d-a979-7075f7e3459e',
        'candidate3',
        'lastname3',
        'candidate3@gmail.com',
        '0606060606',
        'Je suis le candidat 3'
    );

INSERT into
    job_board.recruiter (
        uuid,
        email,
        password,
        company_name,
        company_description
    )
values (
        '17f6f1c9-d44d-42d5-bc9a-b103164e1346',
        'company1@gmail.com',
        'password1',
        'company1',
        'Je suis la company 1'
    ), (
        'cd5c84d6-2494-42d5-bcfb-4a1d99dfdf6a',
        'company2@gmail.com',
        'password2',
        'company2',
        'Je suis la company 2'
    ), (
        'c171233e-049b-4ebd-bd8e-df18621eb596',
        'company3@gmail.com',
        'password3',
        'company3',
        'Je suis la company 3'
    );

INSERT into
    job_board.job_offer (
        uuid,
        title,
        description,
        city,
        recruiter_id
    )
values (
        '2232aaf9-9fb6-45dc-803a-1aabdb88b132',
        'job 1',
        'Je suis le job 1',
        'Paris',
        '17f6f1c9-d44d-42d5-bc9a-b103164e1346'
    ), (
        '060af6bf-8ae8-4b92-9499-99a09b39e5c1',
        'job 2',
        'Je suis le job 2',
        'Paris',
        '17f6f1c9-d44d-42d5-bc9a-b103164e1346'
    ), (
        '709a31c6-a7ce-4838-a3a0-c027c4ce7925',
        'job 3',
        'Je suis le job 3',
        'Tours',
        '17f6f1c9-d44d-42d5-bc9a-b103164e1346'
    ), (
        '0ef722ba-dc88-4baa-be9d-b9b4b8b4d17a',
        'job 4',
        'Je suis le job 4',
        'Tours',
        'cd5c84d6-2494-42d5-bcfb-4a1d99dfdf6a'
    ), (
        '592cf3fa-8b6b-4a1e-b3b1-608f5ab0d3c0',
        'job 5',
        'Je suis le job 5',
        'Nice',
        'cd5c84d6-2494-42d5-bcfb-4a1d99dfdf6a'
    ), (
        '5b6fcf56-940c-4a19-9962-04763839a180',
        'job 6',
        'Je suis le job 6',
        'Lyon',
        'c171233e-049b-4ebd-bd8e-df18621eb596'
    ), (
        'b56fd465-90b8-4f30-ab07-5d1fb0154956',
        'job 7',
        'Je suis le job 7',
        'Bordeaux',
        'c171233e-049b-4ebd-bd8e-df18621eb596'
    );

INSERT into
    job_board.candidate_has_job_offer(candidate_id, job_offer_id)
values (
        '4649605c-6cfb-4829-a033-ce1a7fa06e45',
        '2232aaf9-9fb6-45dc-803a-1aabdb88b132'
    ), (
        'c09e93c0-1980-4a13-9797-581539f33d96',
        '2232aaf9-9fb6-45dc-803a-1aabdb88b132'
    ), (
        '97142cea-c071-4c7d-a979-7075f7e3459e',
        '2232aaf9-9fb6-45dc-803a-1aabdb88b132'
    ), (
        '97142cea-c071-4c7d-a979-7075f7e3459e',
        '709a31c6-a7ce-4838-a3a0-c027c4ce7925'
    ), (
        'c09e93c0-1980-4a13-9797-581539f33d96',
        '5b6fcf56-940c-4a19-9962-04763839a180'
    ), (
        '4649605c-6cfb-4829-a033-ce1a7fa06e45',
        '0ef722ba-dc88-4baa-be9d-b9b4b8b4d17a'
    ), (
        '97142cea-c071-4c7d-a979-7075f7e3459e',
        'b56fd465-90b8-4f30-ab07-5d1fb0154956'
    );