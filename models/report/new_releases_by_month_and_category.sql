with norm as (
    select
        cat_norm,
        extract(year from release_date) as release_year,
        extract(month from release_date) as release_month
from {{ ref('app_store_data_norm') }}
where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
)

select
    cat_norm,
    count(*) as new_release_count,
    release_year,
    release_month

from norm

group by cat_norm, release_year, release_month

order by cat_norm, release_year desc, release_month desc