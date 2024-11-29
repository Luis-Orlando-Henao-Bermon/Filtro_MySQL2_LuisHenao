-- TotalCreditosAlumno(AlumnoID, Anio): Calcula el total de créditos cursados por un alumno en un año específico.

drop function if exists TotalCreditosAlumno;

delimiter // 
create function TotalCreditosAlumno(AlumnoID int, Anio int)
returns int deterministic
begin
	declare creditos int;
    
    set creditos=(select sum(a.creditos) from alumno al inner join alumno_se_matricula_asignatura asma on al.id=asma.id_alumno
    inner join asignatura a on asma.id_asignatura=a.id
    inner join curso_escolar ce on asma.id_curso_escolar=ce.id
    where ce.anyo_inicio=Anio and al.id=AlumnoID) ;
    
    return creditos;
end
// delimiter ;

select TotalCreditosAlumno(1, 2014) as total_creditos;

-- PromedioHorasPorAsignatura(AsignaturaID): Retorna el promedio de horas de clases para una asignatura.

drop function if exists PromedioHorasPorAsignatura;

delimiter //
create function PromedioHorasPorAsignatura(AsignaturaID int)
returns decimal(10,4) deterministic
begin
	declare horas_clase decimal(10,4);
    
    set horas_clase = (select avg(clases.horas_clase) from clases where clases.id_asignatura=AsignaturaID);
	return horas_clase;
end
// delimiter ;

select PromedioHorasPorAsignatura (3);
select avg(horas_clase) from clases where id_asignatura=3; -- este es el resultado que deberia dar pero en la funcion ese select no sirve

-- TotalHorasPorDepartamento(DepartamentoID): Calcula la cantidad total de horas impartidas por un departamento específico.

drop function if exists TotalHorasPorDepartamento;

delimiter // 
create function TotalHorasPorDepartamento(DepartamentoID int)
returns int deterministic
begin
	declare horas_total int;
    
    set horas_total= (select sum(c.horas_clase) from departamento d inner join profesor p on d.id=p.id_departamento 
    inner join asignatura a on p.id=a.id_profesor
    inner join clases c on a.id=c.id_asignatura where d.id=DepartamentoID);
    
    return horas_total;
end
// delimiter ;
select TotalHorasPorDepartamento(1);
-- VerificarAlumnoActivo(AlumnoID): Verifica si un alumno está activo en el cuatrimestre actual basándose en su matrícula.
drop function if exists VerificarAlumnoActivo;

delimiter // 
create function VerificarAlumnoActivo(AlumnoID int, cuatrimestreF int)
returns varchar(50) deterministic
begin
	declare verificacion varchar(50);
    declare cant_asignaturas int;
	
    set cant_asignaturas= (select count(*) from alumno al inner join alumno_se_matricula_asignatura asma on al.id=asma.id_alumno
		inner join asignatura a on asma.id_asignatura=a.id where a.cuatrimestre=cuatrimestreF and al.id=AlumnoID);
        
	if (cant_asignaturas=0) then
		set verificacion='El alumno no esta activo';
	else
		set verificacion= 'El alumno esta activo';
	
    end if;
    
    return verificacion; 
end
// delimiter ;

select VerificarAlumnoActivo(1,1);

-- EsProfesorVIP(ProfesorID): Verifica si un profesor es "VIP" basándose en el número de asignaturas impartidas y evaluaciones de desempeño.
