// Seed Supabase with initial tasks
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://cfnuhjfceceojfykznnm.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_oefauf4bsK7QBNecphPI9w_AGrjl7UK';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const tasks = [
  { task_id: 't1', name: 'Text friends re: run club tonight', detail: 'Confirm who\'s coming. Do this first.', section: 'now' },
  { task_id: 't2', name: 'Text Porsche attendees to confirm', detail: '5 yes, 27 awaiting. Lock in headcount. Free event, Fri Mar 6 @ 1:45pm.', section: 'now' },
  { task_id: 't2b', name: 'Text landlord re: extending lease', detail: 'Ask if you can stay longer past Mar 5. Do this today.', section: 'now' },
  { task_id: 't2c', name: 'Start setting up rental showings', detail: 'Browse listings, schedule viewings. Sublet with Billy as summer backup.', section: 'now' },
  { task_id: 't4', name: 'Call Karan', detail: 'Aces LA, Mar 27 — need theme', section: 'calls' },
  { task_id: 't5', name: 'Call Josh', detail: 'Insiders LA, Mar 20 — need theme', section: 'calls' },
  { task_id: 't6', name: 'Call Jason Schumann', detail: 'Aces NYC, Mar 17 — need theme + venue', section: 'calls' },
  { task_id: 't7', name: 'Call Christian', detail: 'Insiders NYC, Mar 18 at Rob\'s — need theme', section: 'calls' },
  { task_id: 't8', name: 'Call Vishal', detail: 'Need theme', section: 'calls' },
  { task_id: 't9', name: 'Write up Helen\'s theme', detail: 'Condense + improve into dinner theme format. Send to Hanuman to draft.', section: 'create' },
  { task_id: 't10', name: 'Write up other host themes', detail: 'Same for each host. Send to Hanuman after calls.', section: 'create' },
  { task_id: 't11', name: 'Create Luma event pages', detail: 'One per event. Hanuman will draft descriptions.', section: 'create' },
  { task_id: 't12', name: 'Draft Canva graphics', detail: 'Announcement graphics for each March event.', section: 'create' },
  { task_id: 't13', name: 'Draft announcement emails', detail: 'Hanuman will write once events are finalized.', section: 'create' },
  { task_id: 't14', name: 'Draft WhatsApp announcements', detail: 'One per group chat. Hanuman drafts.', section: 'create' },
  { task_id: 't15', name: 'Add March events to Airtable', detail: 'Hanuman can do this via API once details are confirmed.', section: 'admin' },
  { task_id: 't16', name: 'Deals chat: weekly activity + strikes', detail: 'Sunday task.', section: 'admin' },
  { task_id: 't16b', name: 'Prep Monday group chat prompts', detail: 'Get tomorrow\'s prompts ready for Aces + Insiders chats.', section: 'admin' },
  { task_id: 't17', name: 'Send daily group chat spark', detail: 'Sunday prompt.', section: 'admin' },
  { task_id: 't18', name: 'Edit yearly trip invite deck', detail: 'Due Tue Mar 3. Not urgent today.', section: 'later' },
  { task_id: 't19', name: 'Send 10 welcome emails', detail: 'Drafts ready. 15 min of your time.', section: 'later' },
  { task_id: 't20', name: 'Pay invoices + check billing email', detail: 'From overdue list.', section: 'later' },
];

async function seedDatabase() {
  console.log('Seeding database with', tasks.length, 'tasks...');
  
  const { data, error } = await supabase
    .from('tasks')
    .upsert(tasks, { onConflict: 'task_id' });

  if (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }

  console.log('✅ Database seeded successfully!');
  console.log('Inserted/updated', tasks.length, 'tasks');
}

seedDatabase();
