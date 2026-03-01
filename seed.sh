#!/bin/bash

SUPABASE_URL="https://cfnuhjfceceojfykznnm.supabase.co"
SUPABASE_KEY="sb_publishable_oefauf4bsK7QBNecphPI9w_AGrjl7UK"

echo "Seeding database with tasks..."

# Seed each task using the REST API
tasks=(
  '{"task_id":"t1","name":"Text friends re: run club tonight","detail":"Confirm who'\''s coming. Do this first.","section":"now","done":false}'
  '{"task_id":"t2","name":"Text Porsche attendees to confirm","detail":"5 yes, 27 awaiting. Lock in headcount. Free event, Fri Mar 6 @ 1:45pm.","section":"now","done":false}'
  '{"task_id":"t2b","name":"Text landlord re: extending lease","detail":"Ask if you can stay longer past Mar 5. Do this today.","section":"now","done":false}'
  '{"task_id":"t2c","name":"Start setting up rental showings","detail":"Browse listings, schedule viewings. Sublet with Billy as summer backup.","section":"now","done":false}'
  '{"task_id":"t4","name":"Call Karan","detail":"Aces LA, Mar 27 — need theme","section":"calls","done":false}'
  '{"task_id":"t5","name":"Call Josh","detail":"Insiders LA, Mar 20 — need theme","section":"calls","done":false}'
  '{"task_id":"t6","name":"Call Jason Schumann","detail":"Aces NYC, Mar 17 — need theme + venue","section":"calls","done":false}'
  '{"task_id":"t7","name":"Call Christian","detail":"Insiders NYC, Mar 18 at Rob'\''s — need theme","section":"calls","done":false}'
  '{"task_id":"t8","name":"Call Vishal","detail":"Need theme","section":"calls","done":false}'
  '{"task_id":"t9","name":"Write up Helen'\''s theme","detail":"Condense + improve into dinner theme format. Send to Hanuman to draft.","section":"create","done":false}'
  '{"task_id":"t10","name":"Write up other host themes","detail":"Same for each host. Send to Hanuman after calls.","section":"create","done":false}'
  '{"task_id":"t11","name":"Create Luma event pages","detail":"One per event. Hanuman will draft descriptions.","section":"create","done":false}'
  '{"task_id":"t12","name":"Draft Canva graphics","detail":"Announcement graphics for each March event.","section":"create","done":false}'
  '{"task_id":"t13","name":"Draft announcement emails","detail":"Hanuman will write once events are finalized.","section":"create","done":false}'
  '{"task_id":"t14","name":"Draft WhatsApp announcements","detail":"One per group chat. Hanuman drafts.","section":"create","done":false}'
  '{"task_id":"t15","name":"Add March events to Airtable","detail":"Hanuman can do this via API once details are confirmed.","section":"admin","done":false}'
  '{"task_id":"t16","name":"Deals chat: weekly activity + strikes","detail":"Sunday task.","section":"admin","done":false}'
  '{"task_id":"t16b","name":"Prep Monday group chat prompts","detail":"Get tomorrow'\''s prompts ready for Aces + Insiders chats.","section":"admin","done":false}'
  '{"task_id":"t17","name":"Send daily group chat spark","detail":"Sunday prompt.","section":"admin","done":false}'
  '{"task_id":"t18","name":"Edit yearly trip invite deck","detail":"Due Tue Mar 3. Not urgent today.","section":"later","done":false}'
  '{"task_id":"t19","name":"Send 10 welcome emails","detail":"Drafts ready. 15 min of your time.","section":"later","done":false}'
  '{"task_id":"t20","name":"Pay invoices + check billing email","detail":"From overdue list.","section":"later","done":false}'
)

count=0
for task in "${tasks[@]}"; do
  curl -s -X POST "${SUPABASE_URL}/rest/v1/tasks" \
    -H "apikey: ${SUPABASE_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_KEY}" \
    -H "Content-Type: application/json" \
    -H "Prefer: resolution=merge-duplicates" \
    -d "$task" > /dev/null
  ((count++))
  echo "Inserted task $count/22"
done

echo "✅ Database seeded successfully with $count tasks!"
