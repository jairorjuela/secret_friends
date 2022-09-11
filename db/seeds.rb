locations = Location.create([
  { name: 'Marketing' },
  { name: 'Tech' },
  { name: 'Soporte' }
])

workers = Worker.create([
  { name: "Eddard Stark", location: Location.find_by(name: 'Marketing' },
  { name: "Robert Baratheon" location: 'Tech' },
  { name: "Jaime Lannister" location: 'Soporte' },
  { name: "Catelyn Stark" location: 'Soporte' },
  { name: "Cersei Lannister" location: 'Marketing' },
  { name: "Daenerys Targaryen" location: 'Tech' },
  { name: "Jorah Mormont" location: 'Marketing' },
  { name: "Viserys Targaryen" location: 'Marketing' },
  { name: "Jon Snow" location: 'Soporte' },
  { name: "Robb Stark" location: 'Tech' },
  { name: "Sansa Stark" location: 'Soporte' },
  { name: "Arya Stark" location: 'Marketing' },
  { name: "Theon Greyjoy" location: 'Soporte' },
  { name: "Joffrey Baratheon" location: 'Tech' },
  { name: "Sandor Clegane" location: 'Soporte' },
  { name: "Tyrion Lannister" location: 'Marketing' },
  { name: "Davos Seaworth" location: 'Tech' },
  { name: "Samwell Tarly" location: 'Tech' },
  { name: "Stannis Baratheon" location: 'Soporte' },
])
