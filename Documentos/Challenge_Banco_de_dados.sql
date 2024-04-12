SET SERVEROUTPUT ON;

DROP TB_MEDICOS;
DROP TB_REMEDIOS;

--Create prescreve
CREATE TABLE prescreve (
    
    tb_medicos_id_medico   NUMBER NOT NULL,
    tb_remedios_id_remedio NUMBER NOT NULL
);

ALTER TABLE prescreve ADD CONSTRAINT possui_pk PRIMARY KEY ( tb_medicos_id_medico,
                                                             tb_remedios_id_remedio );

ALTER TABLE prescreve
    ADD CONSTRAINT possui_tb_medicos_fk FOREIGN KEY ( tb_medicos_id_medico )
        REFERENCES tb_medicos ( id_medico );

ALTER TABLE prescreve
    ADD CONSTRAINT possui_tb_remedios_fk FOREIGN KEY ( tb_remedios_id_remedio )
        REFERENCES tb_remedios ( id_remedio );

select * from prescreve;

-- Create TB_MEDICOS
CREATE TABLE tb_medicos (
    id_medico         NUMBER NOT NULL,
    nm_medico         VARCHAR2(100 CHAR) NOT NULL,
    dt_experiencia    DATE,
    tp_especializacao VARCHAR2(100 CHAR)
);

ALTER TABLE tb_medicos ADD CONSTRAINT tb_medicos_pk PRIMARY KEY ( id_medico );

-- Insercoes na tabela TB_MEDICOS
INSERT INTO TB_MEDICOS (ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO)
VALUES (1, 'Dr. Jo�o Silva', TO_DATE('01-01-2005', 'DD-MM-YYYY'), 'Cardiologia');

INSERT INTO TB_MEDICOS (ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO)
VALUES (2, 'Dra. Maria Santos', TO_DATE('15-07-2010', 'DD-MM-YYYY'), 'Pediatria');

INSERT INTO TB_MEDICOS (ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO)
VALUES (3, 'Dr. Pedro Almeida', TO_DATE('10-03-2012', 'DD-MM-YYYY'), 'Ortopedia');

INSERT INTO TB_MEDICOS (ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO)
VALUES (4, 'Dra. Ana Oliveira', TO_DATE('20-09-2008', 'DD-MM-YYYY'), 'Ginecologia');

INSERT INTO TB_MEDICOS (ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO)
VALUES (5, 'Dr. Paulo Mendes', TO_DATE('05-05-2015', 'DD-MM-YYYY'), 'Neurologia');

_________________________________________________________________

-- Create TB_REMEDIOS
CREATE TABLE tb_remedios (
    id_remedio           NUMBER NOT NULL,
    nm_remedio           VARCHAR2(100 CHAR) NOT NULL,
    dt_validade          DATE,
    tp_remedio           VARCHAR2(100 CHAR),
    tb_medicos_id_medico NUMBER NOT NULL
);

ALTER TABLE tb_remedios ADD CONSTRAINT tb_remedios_pk PRIMARY KEY ( id_remedio );

-- Insercoes na tabela TB_REMEDIOS
INSERT INTO TB_REMEDIOS (ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO)
VALUES (1, 'Paracetamol', TO_DATE('01-01-2025', 'DD-MM-YYYY'), 'Analgesico');

INSERT INTO TB_REMEDIOS (ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO)
VALUES (2, 'Amoxicilina', TO_DATE('15-07-2023', 'DD-MM-YYYY'), 'Antibiotico');

INSERT INTO TB_REMEDIOS (ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO)
VALUES (3, 'Dipirona', TO_DATE('10-03-2024', 'DD-MM-YYYY'), 'Analgesico');

INSERT INTO TB_REMEDIOS (ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO)
VALUES (4, 'Omeprazol', TO_DATE('20-09-2022', 'DD-MM-YYYY'), 'Antiacido');

INSERT INTO TB_REMEDIOS (ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO)
VALUES (5, 'Atenolol', TO_DATE('05-05-2023', 'DD-MM-YYYY'), 'Anti-hipertensivo');

___________________________________________________________________

-- Bloco Anonimo 1: Consulta e exibe os dados inseridos na tabela TB_MEDICOS
DECLARE
    CURSOR c_medicos IS
        SELECT ID_MEDICO, NM_MEDICO, DT_EXPERIENCIA, TP_ESPECIALIZACAO
        FROM TB_MEDICOS
        ORDER BY ID_MEDICO;
BEGIN
    FOR medico_rec IN c_medicos LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || medico_rec.ID_MEDICO || ', Nome: ' || medico_rec.NM_MEDICO || ', Experiencia: ' || TO_CHAR(medico_rec.DT_EXPERIENCIA, 'DD-MM-YYYY') || ', Especializacao: ' || medico_rec.TP_ESPECIALIZACAO);
    END LOOP;
END;
/

-- Bloco Anonimo 2: Consulta e exibe os dados inseridos na tabela TB_REMEDIOS
DECLARE
    CURSOR c_remedios IS
        SELECT ID_REMEDIO, NM_REMEDIO, DT_VALIDADE, TP_REMEDIO
        FROM TB_REMEDIOS
        ORDER BY ID_REMEDIO;
BEGIN
    FOR remedio_rec IN c_remedios LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || remedio_rec.ID_REMEDIO || ', Nome: ' || remedio_rec.NM_REMEDIO || ', Validade: ' || TO_CHAR(remedio_rec.DT_VALIDADE, 'DD-MM-YYYY') || ', Tipo: ' || remedio_rec.TP_REMEDIO);
    END LOOP;
END;
/

-- Consulta 1: Medicos ordenados por data de experiencia
SELECT * FROM TB_MEDICOS
ORDER BY DT_EXPERIENCIA DESC;


-- Consulta 2: Medicos que tenham a especializacao "Cardiologia"
SELECT * FROM TB_MEDICOS
WHERE TP_ESPECIALIZACAO = 'Cardiologia';

-- Consulta 3: Remedios que estao dentro da validade
SELECT * FROM TB_REMEDIOS
WHERE DT_VALIDADE < SYSDATE;

COMMIT;
