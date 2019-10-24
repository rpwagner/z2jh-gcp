from kubespawner import KubeSpawner

class GCPFormSpawner(KubeSpawner):
    def _options_form_default(self):
        return """
        <p>Create a local GCP endpoint?</p>
        <div class="form-group">
        <input type="radio" name="creategcp" id="true" value="true" checked>
        <label for="true">Yes</label>
        <br>
        <input type="radio" name="creategcp" id="false" value="false">
        <label for="false">No</label>
        </div>
        """
    
    def options_from_form(self, formdata):
        create = formdata.get('creategcp', True)
        env = {'CREATEGCP': "1"}
        if create[0] == 'false':
            create = False
            env = {'CREATEGCP': "0"}
        else:
            create = True
        options = {'creategcp': create,
                   'env': env}
        return options

    def get_env(self):
        env = super().get_env()
        if self.user_options.get('env'):
            env.update(self.user_options['env'])
        return env

c.JupyterHub.spawner_class = GCPFormSpawner
