<script setup lang="ts">
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import listPlugin from '@fullcalendar/list'
import { onMounted, ref } from 'vue'
import type { EventImpl } from '@fullcalendar/core/internal'
import type { Flight } from 'data/flights'

let eventGuid = 0
const events: { id: string; title: string; start: any; extendedProps: { isWaitlist: boolean } | { isWaitlist: boolean } }[] = []
const saverIds = []
const saverWlIds = []
let isWaitlistToggled = true
let calendar: Calendar

const createEventId = () => String(eventGuid++)

const runtimeConfig = useRuntimeConfig()
const flights: Flight[] = JSON.parse(JSON.stringify(runtimeConfig.public.flightsJson)).flights

let waitlistFlights: EventImpl[] = []

for (const destination of flights) {
  for (const flight of destination.Saver.immediate) {
    const i = createEventId()
    saverIds.push(i)
    events.push({
      id: i,
      title: `${destination.Destination}, Saver`,
      start: flight,
      extendedProps: { isWaitlist: false },
    })
  }

  for (const flight of destination.Saver.waitlist) {
    const i = createEventId()
    saverWlIds.push(i)
    events.push({
      id: i,
      title: `${destination.Destination}, Saver Waitlist`,
      start: flight,
      extendedProps: { isWaitlist: true },
    })
  }
}

const calendarEl = ref<HTMLElement | null>(null)

const handleSaverWlToggle = () => {
  // for (const event of calendar.getEvents()) {
  //   if (event._def.extendedProps.isWaitlist === true) {
  //     if (event._def.ui.display == "none") {
  //       event.setProp('display', 'auto');
  //     } else {
  //       event.setProp('display', 'none'); // hide
  //     }
  //   }
  // }
  if (isWaitlistToggled) {
    for (const flight of waitlistFlights)
      flight.setProp('display', 'none') // hide

    isWaitlistToggled = !isWaitlistToggled
  }
  else {
    for (const flight of waitlistFlights)
      flight.setProp('display', 'auto')

    isWaitlistToggled = !isWaitlistToggled
  }
}

onMounted(() => {
  if (calendarEl.value != null) {
    calendar = new Calendar(calendarEl.value, {
      plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,listWeek',
      },
      events,
    })

    calendar.render()
    waitlistFlights = calendar.getEvents().filter(event => event.extendedProps.isWaitlist === true)
  }
})
</script>

<template>
  <div id="calendar" ref="calendarEl" class="calendar" />
  <div class="calendar-toggle" justify-center>
    <label>
      <input
        type="checkbox"
        :checked="isWaitlistToggled"
        @change="handleSaverWlToggle"
      >
      toggle waitlist
    </label>
  </div>
</template>

<style>
.calendar {
  display: flex;
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
  flex-grow: 1;
  padding: 3em;
  padding-bottom: 0em;
}

.calendar-toggle {
  display: flex;
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
  flex-grow: 1;
  padding: 1em;
}

.fc { /* the calendar root */
  max-width: 1100px;
  margin: 0 auto;
}
</style>
