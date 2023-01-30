with norm as (
    select
        cat_norm,
        app_name,
        app_sz_mb,
        extract(year from release_date) as release_year
from {{ ref('app_store_data_norm') }}
where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
),
project as (
    select
        cat_norm,
        app_name as application_name,
        release_year,
        app_sz_mb,
        row_number() over (partition by cat_norm, release_year order by app_sz_mb desc) as rn
    from norm
)
 select
        cat_norm,
        application_name,
        release_year,
        app_sz_mb,
        rn
from project
where rn <= 10
order by cat_norm, release_year desc, rn