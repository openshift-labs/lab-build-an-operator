To see what operators may already have been installed into a cluster and which are available for you to use in your project, you can view them by visiting "Installed Operators" in the web console.

Click on the "Console" tab in the workshop environment to bring up the web console in place of the terminal. You should be presented with the list of projects you have access to.

![](project-list.png)

If the workshop is being run in a way that you have cluster admin access, you will see all projects in the cluster, and not just the project created for this workshop session.

If you don't see the list of projects, click on "Home->Projects" in the left hand menu of the web console. If the left hand menu is not visible, you can expose it by clicking on the hamburger menu on the left side of the web console banner. Alternatively click on this [projects](%console_url%/k8s/cluster/projects)&nbsp;<span class="fas fa-window-restore"></span> link.

With the list of projects visible, it is important to click on the name of your project so that the web console uses it as the context for subsequent steps. If the project list includes all projects in the cluster, copy:

```copy
%project_namespace%
```

into the "Filter Project by name..." text box to limit the list to showing just your project, so you can then click on it.

This should bring you to the [overview](%console_url%/overview/ns/%project_namespace%)&nbsp;<span class="fas fa-window-restore"></span> page for the project.

![](project-overview-page.png)

Now select "Catalog->Installed Operators" from the left hand menu. This should bring up the list of [installed operators](%console_url%/k8s/ns/%project_namespace%/clusterserviceversions)&nbsp;<span class="fas fa-window-restore"></span>.

![](installed-operators.png)

It is possible that you may see other operators which have been enabled and are available. It will depend on what the cluster admin has setup.

The list of installed operators, and what you can do with them through the web console, is determined from the instances of the `clusterserviceversion` resources which exist in a project. You can query them from the command line by running:

```execute
oc get clusterserviceversions
```
