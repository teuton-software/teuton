[<< back](README.md)

# Modes of use

There are **Teuton** ways of use:
1. Classroom
2. Conquest and
3. Standalone

---
## 1. Classroom mode

In this mode, teacher use **Teuton** tool to evaluate the work done by their students into their real or virtual machines. The teacher need to access remotely to these machines.

| Host   | Description |
| ------ | ----------- |
| T-node | Teacher install Teuton software into his machine, and he will connect remotely (using SSH) to every student machine. |
| S-node | Every student machine. |

## 2. Contest mode

Group of contestants execute Teuton software into their own machines just to verify if satisfied the targets/goals of the contest challenge.

On every run, Teuton software send results to contest judges server.
Remote server is configured with SSH service.

| Host   | Description                                                  |
| ------ | ------------------------------------------------------------ |
| T.node | Every contest install Teuton software into their machine. Teuton wll connect via SSH to the server. |
| S-node | The server used by judges to save all the reports. |

## 3. Standalone mode

Student install Teuton software into his own machine, and execute the challenges standalone. It is a good way for practice and learn alone.

| Host   | Descripción |
| ------ | ----------- |
| T-node | Install Teuton software into our machine. |
| S-node | No necessary. |
