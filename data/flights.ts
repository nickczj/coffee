export interface Flight {
  Destination: string
  Saver: Saver
}

export interface Saver {
  miles: number
  immediate: Date[]
  waitlist: Date[]
}
