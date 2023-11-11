# High Availibility

## References

<https://www.reddit.com/r/kubernetes/comments/146aeki/ha_k8s_with_3_combined_controle_worker_nodes/>

## Should we use 3 Control Plane nodes to achieve HA?

If we add 2 additional control plane nodes to the master control pland node then the k8s cluster show a HA status.

After looking at the following argument I don't care if the cluster says HA anymore and will stick to having just 1 control plane node in addition to the master control plane node.  There will then be more worker nodes having more memory for our applications. Unfortunately having 2 master nodes only is not allowed per the last comment below.

**[Is it benificial to have 3 control plane nodes in a cluster?
](https://www.reddit.com/r/kubernetes/comments/146aeki/ha_k8s_with_3_combined_controle_worker_nodes)**

"Another point in 3 nodes HA - if two of the etcd nodes fail for some reason, the 3rd one (healthy) will think, that actually the issue is with itself, since it's 1 and the supposedly problematic are two and the chances of it being bugged, rather than two out of three nodes being down is less, so in the end it stops working too, so it literally kills the whole thing, even if you have a literally healthy member"

"yeah but this issue affect every 3 node control pane setup, they only solution against a 2 node failure would be 5 nodes I guess"

"This is common knowledge for the raft consensus protocol. Go look it up."

"As far as I read a candidate needs to get the majority of votes which is not possible if 2 nodes out of 3 are down. Therefore it cannot be elected. There could be the lucky case that the nodes which went done just where follower then everything would be fine since leader is still up
"

"Since your requirement is to have a 2 node master-only cluster and also have HA capabilities then unfortunately there is no straightforward way to achieve it.

Reason being that a 2 node master-only cluster deployed by kubeadm has only 2 etcd pods (one on each node). This gives you no fault tolerance. Meaning if one of the nodes goes down, etcd cluster would lose quorum and the remaining k8s master won't be able to operate.

Now, if you were ok with having an external etcd cluster where you can maintain an odd number of etcd members then yes, you can have a 2 node k8s cluster and still have HA capabilities."
