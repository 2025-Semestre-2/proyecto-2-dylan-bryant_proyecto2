CREATE PROCEDURE Login
    @username VARCHAR(30),
    @password VARBINARY(256) 
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM usuarios
        WHERE username = @username
          AND password = @password
          AND active = 1
    )
        SELECT 1 AS LoginCorrecto;
    ELSE
        SELECT 0 AS LoginCorrecto;
END
GO
