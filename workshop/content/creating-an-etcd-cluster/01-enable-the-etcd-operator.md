In this first set of exercises you will install an etcd cluster into your project. You will do this by using an Operator for etcd.

Before we can get started, we need to check that the etcd Operator has been enabled and is setup to monitor all namespaces in the cluster. If it hasn't we will enable it from the OperatorHub.

To get to the OperatorHub in the web console first click on the "Console" tab in the workshop environment to bring up the web console in place of the terminal.

Now click on "Operators->OperatorHub" in the left hand menu of the web console. If the left hand menu is not visible, you can expose it by clicking on the hamburger menu on the left side of the web console banner. Alternatively click on this [OperatorHub](%console_url%/operatorhub)&nbsp;<span class="fas fa-window-restore"></span> link.

![](operatorhub-listing.png)

In the web console, find the "Filter by keyword..." text box and enter "etcd". This should restrict the list of operators to just that for etcd.

![](operatorhub-etcd-not-installed.png)

If the card for etcd shows the operator as already installed, check with the workshop instructor as to what to do.

Click on the etcd card. This may result in a popup window being shown warning that this is a community supported operator. Click on "Continue".

![](etcd-community-operator-popup.png)

When you click through, you should see a popup which provides details on the etcd Operator.

![](etcd-operator-details.png)

Ensure that the operator version mentions "clusterwide". Then click "Install". This will bring up a page where you can create a subscription for the etcd Operator. Creating the subscription is what enables the Operator and makes it available to users.

On this page, ensure that the "clusterwide-alpha" channel is selected under "Update Channel". Set the "Installation Mode" to "All namespaces on the cluster".

![](etcd-operator-subscription.png)

When the options are correct, click on "Subscribe". On the next page, wait until the page refreshes to show etcd as installed.

![](etcd-operator-installed-2.png)

Return back to the list of projects by selecting "Home->Projects" in the menu, or click on this [projects](%console_url%/k8s/cluster/projects)&nbsp;<span class="fas fa-window-restore"></span> link.
