# frozen_string_literal: true

users_data = [
  { email: 'cadenmiller@tamu.edu',
    full_name: 'Caden Miller',
    uid: '1',
    avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png',
    committee: 'Development',
    points: '12',
    dues: '0',
    role: 'member',
    created_at: '2024-09-16 18:55:30',
    updated_at: '2024-09-16 18:55:30' },
  { email: 'erikachtermann@tamu.edu',
    full_name: 'Erik Achtermann',
    uid: '2',
    avatar_url: 'https://lh3.googleusercontent.com/a/ACg8ocJ56OzJMcpYDm3gLwARkJ2P8iBLIXH61GdZgzi_nVLBOJXf8A=s96-c',
    committee: 'Development',
    points: '12',
    dues: '0',
    role: 'admin',
    created_at: '2024-09-16 18:55:30',
    updated_at: '2024-09-16 18:55:30' },
  { email: 'jimmy57guandolo@tamu.edu',
    full_name: 'James Guandolo',
    uid: '3',
    avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png',
    committee: 'Development',
    points: '12',
    dues: '0',
    role: 'admin',
    created_at: '2024-09-16 18:55:30',
    updated_at: '2024-09-16 18:55:30' },
  { email: 'scpanakin@tamu.edu',
    full_name: 'Shanti Patel',
    uid: '4',
    avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png',
    committee: 'Development',
    points: '12',
    dues: '0',
    role: 'admin',
    created_at: '2024-09-16 18:55:30',
    updated_at: '2024-09-16 18:55:30' }
]

# create or update user
users_data.each do |user_data|
  user = User.find_or_create_by(email: user_data[:email])
  user.update!(user_data)
end

links_data = [
  { title: 'Instagram',
    link: 'https://www.instagram.com/heattamu/?hl=en',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' },
  { title: 'BUILD X HEAT',
    link: 'https://docs.google.com/forms/d/e/1FAIpQLSdUIiAj3qct9Dcfuu769syNJca_N5rSwbhFgOKJq7Z37YX0nQ/viewform',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' },
  { title: 'Street Cleanup 09/20/24',
    link: 'https://docs.google.com/forms/d/e/1FAIpQLSeTFM7Lj5xR8vTtPm3mWMueCkEHVeYSU8q713OrrVx2IhmoFg/viewform',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' },
  { title: 'TAMU Menstrual Equity Petition!',
    link: 'https://www.change.org/p/urge-texas-a-m-university-to-provide-free-menstrual-hygiene-products-on-campus?recruiter=1334100253&recruited_by_id=10135200-e17c-11ee-91d9-bd1dbfd06ae6&utm_source=share_petition&utm_campaign=petition_dashboard_share_modal&utm_medium=copylink',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' },
  { title: 'Period Project Usage/Feedback Form',
    link: 'https://docs.google.com/forms/d/e/1FAIpQLScuSE2R3dRu-QYSq6XBLjtUgIGySxmwWdo-8C4ZIKLmQr5Ktg/viewform?usp=sf_link',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' },
  { title: 'Flywire- pay dues and get merch!',
    link: 'https://tamu.estore.flywire.com/search?q=*%3A*&catalogName=Human+Environmental+Animal+Team',
    created_at: '2024-09-26 21:19:30',
    updated_at: '2024-09-26 21:19:30' }
]

links_data.each do |link_data|
  link = Link.find_or_create_by(title: link_data[:title])
  link.update!(link_data)
end
