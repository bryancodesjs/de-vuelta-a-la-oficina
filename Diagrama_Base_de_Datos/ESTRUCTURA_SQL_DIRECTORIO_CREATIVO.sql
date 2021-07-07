

CREATE TABLE usuario
(
	id INT PRIMARY KEY IDENTITY,
	id_provincia INT,
	nombre VARCHAR(95) NOT NULL,
	apellido VARCHAR(95) NOT NULL,
	profesion VARCHAR(190),
	descripcion_general TEXT,
	telefono VARCHAR(20) NOT NULL,
	email VARCHAR(95) NOT NULL,
	clave VARCHAR(255) NOT NULL,
	salt_clave VARCHAR(95) NOT NULL,
	fecha_ingreso DATETIME NOT NULL,
	habilitado BIT NOT NULL

	--CONSTRAINT FK_USUARIO_PROVINCIA FOREIGN (id_provincia) REFERENCES provincia(id)
);

GO

CREATE TABLE roles
(
	id INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(95) NOT NULL
);

GO

CREATE TABLE usuario_rol
(
	id INT PRIMARY KEY IDENTITY,
	id_usuario INT NOT NULL,
	id_rol INT NOT NULL,

	CONSTRAINT FK_UsuarioRol_USUARIO FOREIGN KEY (id_usuario) REFERENCES usuario(id),
	CONSTRAINT FK_UsuarioRol_ROLES FOREIGN KEY (id_rol) REFERENCES roles(id)
);

GO

CREATE TABLE permisos
(
	id INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(95) NOT NULL
);

GO

CREATE TABLE roles_permiso
(
	id INT PRIMARY KEY IDENTITY,
	id_roles INT NOT NULL,
	id_permiso INT NOT NULL,

	CONSTRAINT FK_RolesPermiso_ROLES FOREIGN KEY (id_roles) REFERENCES roles(id),
	CONSTRAINT FK_RolesPermiso_PERMISOS FOREIGN KEY (id_permiso) REFERENCES permisos(id)
);

GO

CREATE TABLE perfil_usuario
(
	id INT PRIMARY KEY IDENTITY,
	id_usuario INT NOT NULL,
	visitas INT NOT NULL,
	valoraciones INT NOT NULL,
	instagram VARCHAR(95),
	facebook VARCHAR(95),
	youtbe VARCHAR(95),
	img_banner VARCHAR(95) NULL,

	CONSTRAINT FK_PerfilUsuario_USUARIO FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

GO

CREATE TABLE solicitud_perfil_usuario
(
	id INT PRIMARY KEY IDENTITY,
	id_usuario INT NOT NULL,
	visitas INT NOT NULL,
	valoraciones INT NOT NULL,
	instagram VARCHAR(95) NOT NULL,
	facebook VARCHAR(95) NOT NULL,
	youtbe VARCHAR(95) NOT NULL,
	img_banner VARCHAR(95) NOT NULL,

	CONSTRAINT FK_SOLICITUD_PerfilUSUARIO FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

GO

CREATE TABLE obra
(
	id INT PRIMARY KEY IDENTITY,
	id_perfil INT,
	img_obra VARCHAR(555) NOT NULL,
	nombre_obra VARCHAR(95) NOT NULL,
	descripcion_obra VARCHAR(555) NOT NULL,
	ubicacion VARCHAR(95) NOT NULL,
	fecha_registro datetime NOT NULL,
	visitas INT NOT NULL,
	valoraciones INT NOT NULL,
	estado_obra BIT,

	CONSTRAINT FK_OBRA_PerfilUsuario FOREIGN KEY (id_perfil) REFERENCES perfil_usuario(id)
);

GO

CREATE TABLE mensajes
(
	id INT PRIMARY KEY IDENTITY,
	id_emisor INT NOT NULL,
	id_receptor INT NOT NULL,

	CONSTRAINT FK_MENSAJES_USUARIO_Emisor FOREIGN KEY (id_emisor) REFERENCES usuario(id),
	CONSTRAINT FK_MENSAJES_USUARIO_Receptor FOREIGN KEY (id_receptor) REFERENCES usuario(id),
);

GO

CREATE TABLE detalle_mensaje
(
	id INT PRIMARY KEY IDENTITY,
	id_mensaje INT NOT NULL,
	mensaje TEXT NOT NULL,
	leido BIT NOT NULL,
	fecha datetime NOT NULL,

	CONSTRAINT FK_DetalleMensaje_MENSAJES FOREIGN KEY (id_mensaje) REFERENCES mensajes(id)
);

GO

CREATE TABLE token_log
(
	id INT PRIMARY KEY IDENTITY,
	id_usuario INT NOT NULL,
	token VARCHAR(255) NOT NULL,
	fecha_expiracion DATETIME NOT NULL,
	fecha_registro DATETIME NOT NULL,

	CONSTRAINT FK_TokenLogs_USUARIO FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);


