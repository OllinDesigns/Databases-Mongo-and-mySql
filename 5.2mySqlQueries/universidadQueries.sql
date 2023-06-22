-- Returns a list with the first last name, second last name and first name of all the students. The list must be ordered alphabetically from lowest to highest by first last name, second last name and first name.
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

-- Find out the first and last names of students who have not registered their phone number in the database.
SELECT nombre, apellido1
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- Returns the list of students who were born in 1999.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento >= '1999-01-01' AND fecha_nacimiento <= '1999-12-31';

-- Returns the list of teachers who have not registered their phone number in the database and also their NIF ends in K.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
WHERE p.telefono IS NULL AND p.nif LIKE '%K';

-- Returns the list of subjects that are taught in the first semester, in the third year of the degree that has the identifier 7.
SELECT a.nombre
FROM asignatura a
JOIN grado g ON a.id_grado = g.id
JOIN curso_escolar c ON g.id = c.id
WHERE c.anyo_inicio = 2015 AND a.cuatrimestre = 3 AND g.id = 7;

-- Returns a list of professors along with the name of the department to which they are linked. The listing should return four columns, first last name, second last name, first name and department name. The result will be sorted alphabetically from lowest to highest by last name and first name.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
JOIN departamento d ON pr.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- Returns a list with the name of the subjects, start year and end year of the student's school year with NIF 26902806M.
SELECT a.nombre AS subject_name, c.anyo_inicio AS start_year, c.anyo_fin AS end_year
FROM alumno_se_matricula_asignatura AS ama
JOIN persona AS p ON ama.id_alumno = p.id
JOIN asignatura AS a ON ama.id_asignatura = a.id
JOIN curso_escolar AS c ON ama.id_curso_escolar = c.id
WHERE p.nif = '26902806M';

-- Returns a list with the name of all the departments that have professors who teach a subject in the Degree in Computer Engineering (Plan 2015).
SELECT DISTINCT d.nombre AS department_name
FROM departamento AS d
JOIN profesor AS p ON d.id = p.id_departamento
JOIN asignatura AS a ON p.id_profesor = a.id_profesor
JOIN grado AS g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- Returns a list of all students who have enrolled in a subject during the 2018/2019 school year.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno
JOIN curso_escolar c ON am.id_curso_escolar = c.id
WHERE c.id = 5;

-- Solve the following 6 queries using the LEFT JOIN and RIGHT JOIN clauses.

-- Returns a list with the names of all the professors and the departments they are linked to. The list must also show those professors who do not have any associated department. The listing must return four columns, department name, first last name, second last name and teacher's name. The result will be sorted alphabetically from lowest to highest by department name, last name and first name.
SELECT d.nombre AS department_name, p.apellido1 AS last_name, p.apellido2 AS second_last_name, p.nombre AS teacher_name
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY department_name ASC, last_name ASC, teacher_name ASC;

-- Returns a list of professors who are not associated with a department.
SELECT p.apellido1 AS last_name, p.apellido2 AS second_last_name, p.nombre AS teacher_name
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
RIGHT JOIN departamento d ON pr.id_departamento = d.id
WHERE d.id IS NULL
ORDER BY last_name ASC, teacher_name ASC;

-- Returns a list of departments that do not have associate professors.
SELECT d.nombre AS department_name
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_profesor IS NULL;

-- Returns a list of teachers who do not teach any subjects.
SELECT p.nombre AS teacher_name, p.apellido1 AS last_name, p.apellido2 AS second_last_name, pr.id_profesor AS 'teacher id'
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL AND p.tipo = 'profesor';

-- Returns a list of subjects that do not have an assigned teacher.
SELECT a.nombre AS 'subject name with no assigned teacher'
FROM asignatura a
LEFT JOIN profesor p ON a.id_profesor = p.id_profesor
WHERE a.id_profesor IS NULL;

-- Returns a list of all departments that have not taught subjects in any school year.
SELECT d.nombre AS department_name
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;


-- Summary Queries:

-- Returns the total number of students there.
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno';

-- Calculate how many students were born in 1999.
SELECT nombre, apellido1, apellido2, fecha_nacimiento
FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento REGEXP '1999';

-- Calculate how many teachers there are in each department. The result should only show two columns, one with the name of the department and another with the number of professors in that department. The result must only include the departments that have associate professors and must be ordered from highest to lowest by the number of professors.
SELECT d.nombre AS department_name, COUNT(p.id_profesor) AS num_professors
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre
ORDER BY num_professors DESC;

-- Returns a list with the name of all the existing degrees in the database and the number of subjects each one has. Note that there may be degrees that do not have associated subjects. These grades must also appear in the listing. The result must be ordered from highest to lowest by the number of subjects.
SELECT g.nombre AS degree_name, COUNT(a.id) AS num_subjects
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY num_subjects DESC;

-- Returns a list with the name of all the existing degrees in the database and the number of subjects each has, of the degrees that have more than 40 associated subjects.
SELECT g.nombre AS degree_name, COUNT(a.id) AS num_subjects
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING num_subjects > 40
ORDER BY num_subjects DESC;

-- Returns a list showing the name of the degrees and the sum of the total number of credits for each subject type. The result must have three columns: name of the degree, type of subject and the sum of the credits of all subjects of this type.
SELECT g.nombre AS degree_name, a.tipo AS subject_type, SUM(a.creditos) AS total_credits
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY g.nombre, a.tipo;

-- Returns a list that shows how many students have enrolled in a subject in each of the school years. The result must show two columns, one column with the start year of the school year and another with the number of enrolled students.
SELECT ce.anyo_inicio AS school_year_start, COUNT(*) AS enrolled_students
FROM curso_escolar ce
JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar
GROUP BY ce.anyo_inicio
ORDER BY ce.anyo_inicio;

-- Returns a list with the number of subjects taught by each teacher. The list must take into account those professors who do not teach any subjects. The result will show five columns: id, name, first last name, second last name and number of subjects. The result will be ordered from highest to lowest by the number of subjects.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS number_of_subjects
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor'
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY number_of_subjects DESC;

-- Returns all data for the youngest student.
SELECT *
FROM persona
WHERE fecha_nacimiento = (
    SELECT MAX(fecha_nacimiento)
    FROM persona
    WHERE tipo = 'alumno'
);

-- Returns a list of professors who have an associated department and who do not teach any subjects.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL;