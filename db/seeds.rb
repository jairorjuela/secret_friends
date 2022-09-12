locations = Location.create([
  { name: 'Marketing' },
  { name: 'Tech' },
  { name: 'Soporte' }
])

workers = Worker.create([
  { name: "Eddard Stark", location: Location.find_by(name: 'Marketing') },
  { name: "Robert Baratheon", location: Location.find_by(name: 'Tech') },
  { name: "Jaime Lannister", location: Location.find_by(name: 'Soporte') },
  { name: "Catelyn Stark", location: Location.find_by(name: 'Soporte') },
  { name: "Cersei Lannister", location: Location.find_by(name: 'Marketing') },
  { name: "Daenerys Targaryen", location: Location.find_by(name: 'Tech') },
  { name: "Jorah Mormont", location: Location.find_by(name: 'Marketing') },
  { name: "Viserys Targaryen", location: Location.find_by(name: 'Marketing') },
  { name: "Jon Snow", location: Location.find_by(name: 'Soporte') },
  { name: "Robb Stark", location: Location.find_by(name: 'Tech') },
  { name: "Sansa Stark", location: Location.find_by(name: 'Soporte') },
  { name: "Arya Stark", location: Location.find_by(name: 'Marketing') },
  { name: "Theon Greyjoy", location: Location.find_by(name: 'Soporte') },
  { name: "Joffrey Baratheon", location: Location.find_by(name: 'Tech') },
  { name: "Sandor Clegane", location: Location.find_by(name: 'Soporte') },
  { name: "Tyrion Lannister", location: Location.find_by(name: 'Marketing') },
  { name: "Davos Seaworth", location: Location.find_by(name: 'Tech') },
  { name: "Samwell Tarly", location: Location.find_by(name: 'Tech') },
  { name: "Stannis Baratheon", location: Location.find_by(name: 'Soporte') },
])
