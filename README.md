<h1>IrisWebClient</h1>
<p><b>Rich GUI web application for the InterSystems IRIS database</b></p>

<p>
A modern web client built with <b>Delphi + uniGUI</b> and connected to 
<b>InterSystems IRIS</b> via <b>ODBC</b>.  
The application demonstrates full <b>CRUD operations</b>, referential property handling, 
and IRIS-native filtering using implicit JOINs.
</p>

<h2>How to Test</h2>
<p><b>If you want to test the app without installing anything:</b><p>
<a href="https://demo.irisclient.org">https://demo.irisclient.org</a>
<p> 
Login: demo<br>
Password: demo
</p>

<h2>Features</h2>
<ul>
  <li><b>Cross‑Platform Deployment</b></li>
  <ul>
    <li>Windows: Service, Standalone EXE, ISAPI.</li>
    <li>Linux: Standalone executable or Apache module.</li>
    <li>Linux 64‑bit builds compiled via Delphi FireMonkey.</li>
  </ul>
  <li><b>Full CRUD</b> (Create, Read, Update, Delete) for IRIS persistent classes</li>
  <li><b>Insert/update referential properties</b> such as:
    <ul>
      <li>Person → Spouse</li>
      <li>Employee → Company</li>
    </ul>
  </li>
  <li><b>IRIS implicit JOIN filtering:</b>:
    <ul>
      <li>Filter by nested referential fields.</li>
      <li>Examples:
        <ul>
          <li>Person.Spouse.Name</li>
          <li>Employee.Company.Name</li>
          <li>Address.City</li>
        </ul>
      </li>
    </ul>
  </li>
  <li>Rich web UI built with uniGUI.</li>
  <li>ODBC connectivity for SQL access to IRIS.</li>
  <li>Zero‑installation browser client.</li>
</ul>

<h2>Architecture Overview</h2>
<ul>
  <li><b>Frontend:</b> uniGUI (Delphi)   https://unigui.com/ </li>
  <li><b>Backend:</b> InterSystems IRIS   https://www.intersystems.com/</li>
  <li><b>Connectivity:</b> IRIS ODBC driver, used over standard FireDAC data access library in Delphi</li>
  <li><b>Data Model:</b> Person, Employee, Company, Address (with referential relationships)</br>  
  <a href="https://openexchange.intersystems.com/package/ObjectScript-Native-API-demo"><b>ObjectScript-Native-API-demo</b></a>
  </li> 
</ul>

<h2>CRUD Demonstration</h2>
<p>The application implements full CRUD for all major entities:</p>

<table>
  <tr>
    <th>Entity</th>
    <th>Create</th>
    <th>Read</th>
    <th>Update</th>
    <th>Delete</th>
    <th>Referential Fields</th>
  </tr>
  <tr>
    <td>Person</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>Spouse, Address</td>
  </tr>
  <tr>
    <td>Employee</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>Company</td>
  </tr>
  <tr>
    <td>Company</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>✔</td>
    <td>—</td>
  </tr>
</table>

<h2>Referential Property Handling</h2>
<p>
The application demonstrates how to:
</p>
<ul>
  <li>Insert and update objects with references.</li>
  <li>Display referential fields in grids.</li>
  <li>Resolve nested properties (e.g., Person.Spouse.Name).</li>
  <li>Maintain referential integrity through UI controls.</li>
</ul>

<h2>Filtering with IRIS Implicit JOIN</h2>
<p>
IRIS automatically resolves referential properties in SQL queries.  
This application shows how to filter by nested properties without writing explicit JOINs.
</p>

<pre><code>
SELECT * FROM ONAPI.Person WHERE Spouse->Name LIKE 'A%'
</pre></code>

<h2>Installation on Windows host</h2>
<ul>
  <li>Install IRIS</li>
  <li>Load sample classes to IRIS</br>
  use <a href="https://openexchange.intersystems.com/package/ObjectScript-Native-API-demo"><b>ObjectScript-Native-API-demo</b></a></br>  
  <pre><code>git clone https://github.com/r-cemper/ObjectScript-Native-API.git</code></pre>
  load classes
  <pre><code>
  USER>do $system.OBJ.LoadDir("...\ObjectScript-Native-API\src\ONAPI","ck")
  </code></pre>Run the database installation. This is an interactive process; you will be asked how many Persons, Employees, and Companies to create.<br>
  <pre><code>USER>do ##class(ONAPI.demo).Run()</code></pre>
  </li>
  <li>Configure ODBC DSN<br>
  Create a 'User DSN' for InterSystems IRIS ODBC driver
  </li>  
  <li>Build the uniGUI IrisWebClient.exe application in Delphi</br>
	Delphi 12 CE was used to create this aplication, but the application should build </>
	with no problems on any modern Delphi version since uniGUI is only third-party dependency,</br> 
	but indeed the breakthrough technology.
  </li>
  
  <li>Update connection.ini with ODBC connection parameters and make sure the file is located in the same directory as IrisWebClient.exe
  <pre><code>  DataSource=...
  User_Name=...
  Password=...
  ODBCDriver=InterSystems IRIS ODBC35
  Database=...
  DriverID=ODBC</code></pre> 
  </li>
  <li>Make sure login.html  is located in the same directory as IrisWebClient.exe.</li>
  <li>Run IrisWebClient.exe and navigate your browser to the default address and port:</br>  
  http://localhost:8077</li>
  
</ul>

<h2>Screenshots</h2>

<p><b>Main Dashboard</b></p> 
<img src="docs/img/dashboard.png" width="800">
<p>Use implicit JOIN to select referential fields.</p>
<pre><code>SELECT *, Spouse->Name AS SpouseName FROM ONAPI.Person
</code></pre>
<p>This works perfectly fine with FireDAC over IRIS ODBC.</p>
<p><b>IRIS ODBC does accept object‑projection syntax (->) when the SQL is passed through FireDAC unchanged</b></p>
</br>
<p><b>Assigning referential properties</b></p> 
<img src="docs/img/person_spouse.png" width="800">
<p>Select a Person, click button in SpouseName column, select a Spouse, click 'OK' to confirm assignment</p> 
<p>Implementation using ODBC layer as FireDAC dataset. Assign referetial field with reference ID and do Post.</p>
<pre><code> 
    FTargetDataSet.Edit;
    FTargetDataSet['Spouse'] := qryPersonDict['ID'];
    FTargetDataSet.Post;
</pre></code>			
</br>
<p><b>Searchable Lookup Combobox</b></p>
<img src="docs/img/lookupcombobox.png">
<p>Assign <code>Employee-&gt;Company</code> by selecting a company in the searchable lookup combobox.</p>
<p>
Lookup persistent fields in Delphi provide a true <b>No‑Code</b> solution.  
Simply configure the Lookup properties in the Object Inspector.
</p>
<img src="docs/img/lookup_field_setup.png">
</br>
<p><b>Filtering using referential properties</b></p> 
<img src="docs/img/filter.png" width="800">
<p>Use 'Filter' button to call Filter dialog and add add filtering criteria</p> 
</br>
<p><b>Calendar widget in the Grid</b></p> 
<img src="docs/img/calendar.png">

<!--
<h2>Roadmap</h2>
<ul>
  <li>REST API layer</li>
  <li>ZPM packaging</li>
  <li>Docker deployment</li>
  <li>Authentication module</li>
  <li>Additional referential examples</li>
</ul>
-->
<h2>License</h2>
<p>MIT <a href="https://github.com/dima72/IrisWebClient/blob/master/LICENSE">LICENSE</a> </p>
