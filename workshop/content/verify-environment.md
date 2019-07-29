This workshop environment provides you with an interactive terminal in your web browser, along with access to the web console for the OpenShift cluster you are using. The user shell has access to all the command line tools you require. You do not need to install anything on your local computer.

Before starting, we need to verify that the environment you are using is setup correctly for the workshop and that you have access to a project you can use.

To verify that the project has been created, run:

```execute
oc project
```

Did you type the command in yourself? If you did, click on the command instead and you will find that it is executed for you. You can click on any command which has the <span class="fas fa-play-circle"></span> icon shown to the right of it, and it will be copied to the interactive terminal and run.

You may also see other icons used. The <span class="fas fa-copy"></span> icon will appear when you need to copy the text shown and paste it to a separate window. Click on the text, and the text will be automatically copied to your copy and paste buffer, ready for you to paste it.

Where you see the <span class="fas fa-user-edit"></span> icon, clicking on the text will again automatically copy it to your copy and paster buffer. In this case, the different icon indicates that when you paste it to the required window, that you will need to then edit details of the text before using it.

Having run `oc project`, you should see a message similar to:

```
Using project "%project_namespace%" on server "https://...".
```

You should see that the current project is `%project_namespace%`.

To check that you can deploy applications, run the command:

```execute
oc auth can-i create pods
```

If the output from the `oc auth can-i` command is `yes`, you are all good to go.

If instead of the output `yes`, you see:

```
no - no RBAC policy matched
```

or any other error message, report the issue to the workshop lead, or one of the helpers.
