with norm as (
    select
        -- round to nearest
        round((sum(avg_review_score * review_count) / sum(review_count)), 1) as rating_avg,
        cat_norm
from {{ ref('app_store_data_norm') }}
where cat_norm in ('GAME', 'HEALTH', 'MUSIC')
group by cat_norm
)

select
    rating_avg,
    cat_norm

from norm
