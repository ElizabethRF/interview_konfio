SET COLSEP ","
spool C:\R\EXAM\interview_konfio\06_bonus_track\export.txt
SELECT
    'FECHA',
    'AUTO',
    'MORTGAGE',
    'REVOLVING',
    'INSTALLMENTS',
    'TOTAL'
FROM
    dual
UNION ALL
SELECT
    TO_CHAR(fecha),
    TO_CHAR("'AUTO'"),
    TO_CHAR("'MORTGAGE'"),
    TO_CHAR("'REVOLVING'"),
    TO_CHAR("'INSTALLMENTS'"),
    TO_CHAR(total)
FROM
    loans.reporte2 r;
spool off;

