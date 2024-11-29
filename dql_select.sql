-- 1. Encuentra el profesor que ha impartido más asignaturas en el último año académico.

select p.nombre, p.apellido1, count(a.id_profesor) as cantidad_asignatura from profesor p inner join asignatura a on p.id=a.id_profesor
inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
inner join curso_escolar ce on asma.id_curso_escolar=ce.id
where ce.anyo_inicio= 2017
 group by 1,2 order by 3 desc limit 1;
-- no muestra nada ya que no hay ninguna asignatura con profesor en la tabla alumno_se_matricula_asignatura

-- 2. Lista los cinco departamentos con mayor cantidad de asignaturas asignadas.

select d.*, count(*) as asignaturas from departamento d inner join profesor p on d.id=p.id_departamento
inner join asignatura a on p.id=a.id_profesor group by 1 order by 2 desc limit 5;

-- 3. Obtén el total de alumnos y docentes por departamento.

select d.*, count(p.id) as profesores, count(asma.id_alumno) as alumnos from departamento d inner join profesor p on d.id=p.id_departamento
inner join asignatura a on p.id=a.id_profesor 
inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
group by 1 ;
-- no hay asignaturas con profesor en la tabla alumno_se_matricula_asignatura por ende aparece vacio

-- 4. Calcula el número total de alumnos matriculados en asignaturas de un género específico en un semestre determinado.

select count(*) as cantidad_alumnos from asignatura a inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
inner join alumno al on asma.id_alumno= al.id
where al.sexo='H' ;
 
-- 5. Encuentra los alumnos que han cursado todas las asignaturas de un grado específico.


-- 6. Lista los tres grados con mayor número de asignaturas cursadas en el último semestre.

select g.nombre, count(a.id) as numero_asignaturas from grado g inner join asignatura a on g.id=a.id_grado group by 1 order by 2 desc limit 3;

-- 7. Muestra los cinco profesores con menos asignaturas impartidas en el último año académico.

select p.nombre, p.apellido1, count(a.id_profesor) as cantidad_asignatura from profesor p inner join asignatura a on p.id=a.id_profesor
inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
inner join curso_escolar ce on asma.id_curso_escolar=ce.id
where ce.anyo_inicio= max(ce.anyo_inicio)
 group by 1,2 order by 3 limit 5;

-- 8. Calcula el promedio de edad de los alumnos al momento de su primera matrícula.

select avg(timestampdiff(year,fecha_nacimiento,'2024-11-29')) from alumno;

-- 9. Encuentra los cinco profesores que han impartido más clases de un mismo grado.

select p.nombre, p.apellido1,g.nombre, count(c.id) from profesor p inner join asignatura a on p.id=a.id_profesor
inner join grado g on a.id_grado=g.id
inner join clases c on a.id=c.id_asignatura group by 1,2,3;

-- 10. Genera un informe con los alumnos que han cursado más de 10 asignaturas en el último año.

select al.nombre,al.apellido1, count(a.id) as 'numero_asignaturas' from alumno al inner join alumno_se_matricula_asignatura asma on al.id=asma.id_alumno
inner join asignatura a on asma.id_asignatura=a.id
inner join curso_escolar ce on asma.id_curso_escolar=ce.id
where ce.anyo_inicio=2017
group by 1,2
having numero_asignaturas >10;

-- 11. Calcula el promedio de créditos de las asignaturas por grado.

select g.nombre, avg(a.creditos) from grado g inner join asignatura a on g.id=a.id_grado group by 1;

-- 12. Lista las cinco asignaturas más largas (en horas) impartidas en el último semestre.

select a.nombre, sum(c.horas_clase) as horas_impartidas from profesor p inner join asignatura a on p.id=a.id_profesor
inner join grado g on a.id_grado=g.id
inner join clases c on a.id=c.id_asignatura 
where a.cuatrimestre=3
group by 1;

-- 13. Muestra los alumnos que han cursado más asignaturas de un género específico.

select al.nombre, count(*) as cantidad_asignaturas from asignatura a inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
inner join alumno al on asma.id_alumno= al.id
where al.sexo='H'
group by 1  order by 2 desc;

-- 14. Encuentra la cantidad total de horas cursadas por cada alumno en el último semestre.

select al.nombre,al.apellido1, sum(c.horas_clase) from alumno al inner join alumno_se_matricula_asignatura asma on al.id=asma.id_alumno
inner join asignatura a on asma.id_asignatura=a.id
inner join clases c on a.id=c.id_asignatura
where a.cuatrimestre=1
group by 1,2;


-- 15. Muestra el número de asignaturas impartidas diariamente en cada mes del último trimestre.



-- 16. Calcula el total de asignaturas impartidas por cada profesor en el último semestre.

select p.nombre,p.apellido1, count(a.id) from profesor p inner join asignatura a on p.id=a.id_profesor 
where a.cuatrimestre=3
group by 1,2 ;

-- 17. Encuentra al alumno con la matrícula más reciente.

select * from alumno order by 1 desc limit 1;

-- 18. Lista los cinco grados con mayor número de alumnos matriculados durante los últimos tres meses.



-- 19. Obtén la cantidad de asignaturas cursadas por cada alumno en el último semestre.

select al.nombre,al.apellido1, count(a.id) from alumno al inner join alumno_se_matricula_asignatura asma on al.id=asma.id_alumno
inner join asignatura a on asma.id_asignatura=a.id 
where a.cuatrimestre=3 group by 1,2;

-- 20. Lista los profesores que no han impartido clases en el último año académico.

select profesor.nombre, profesor.apellido1 from profesor where profesor.id not in (select p.id from profesor p inner join asignatura a on p.id=a.id_profesor
inner join alumno_se_matricula_asignatura asma on a.id=asma.id_asignatura
inner join curso_escolar ce on asma.id_curso_escolar=ce.id
where ce.anyo_inicio= 2017);
