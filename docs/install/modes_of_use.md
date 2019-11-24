There are several **Teuton** ways of use: Classroom, Conquest and Standalone.

For every mode exists 2 types of nodes: T-Node and S-Node.

---

## Classroom mode

In this mode, a teacher use **Teuton** tool to evaluate the work done by their students into their real or virtual machines. The teacher need to access remotely to these machines.

| Node | Description |
| ---- | ----------- |
| T    | Teacher install Teuton software into his machine, and he will connect remotely (using SSH) to every student machine. |
| S    | Every student machine. |

---

## Contest mode

We will hace a group of contestants who decide to do challenges and execute Teuton software into their own machines just to verify if satisfied the targets/goals of the challenge.

On every run, Teuton software send results to remote server configured with SSH (used by the contest judges).

| Node | Description                                                  |
| ---- | ------------------------------------------------------------ |
| T    | Every contest install Teuton software into their machine. Teuton wll connect via SSH to the server. |
| S    | The server used by judges to save all the reports. |

---

## Standalone mode

Install Teuton software into our own machine, and execute the challenges as you want. It is a good way for standalone learning .

| Node | Descripción |
| ---- | ----------- |
| T    | Install Teuton software into our machine. |
| S    | No necessary. |
